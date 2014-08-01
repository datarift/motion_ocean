module MotionOcean
  module API
    class Client
      attr_reader :base_url
      
      def initialize(base_url, &block)
        base_url += '/' unless base_url.end_with? '/'
        @base_url = NSURL.URLWithString(base_url)
        @headers = {}
      
        # yield(self) if block_given?
        if block_given?
          case block.arity
          when 0
            instance_eval(&block)
          when 1
            block.call(self)
          end
        end
      end
      
      [:delete, :get, :head, :post, :put].each do |verb|
        define_method verb do |path, options = {}, &block|
          request = create_request(path, options, verb)
          create_task(request, &block).resume
        end
      end
      
      def header(name, value)
        @headers[name] = value
      end
    
      def authorization(options = {})
        header "Authorization", MotionOcean::API::Authorization.build(options)
      end
    
      private
      def config
        NSURLSessionConfiguration.defaultSessionConfiguration
      end
    
      def session
        NSURLSession.sessionWithConfiguration(config)
      end
    
      def create_request(path, options, method)
        headers = options.fetch(:headers, {})
        body = options.fetch(:body, nil)
        query = options.fetch(:query, nil)

        url = create_url(path, query)
        
        request = NSMutableURLRequest.requestWithURL(url)
        
        set_headers(request, @headers.merge(headers))
        set_body(request, body) if body
        
        request.setHTTPMethod(method.to_s.upcase)
        
        request
      end
      
      def create_url(path, query)
        query_string = query.map { |key, value| "#{key}=#{value}" }.join '&' unless query.nil?
        
        path.sub!('/', '') if path.start_with? '/'
        
        components = NSURLComponents.new
        components.path = path
        components.query = query_string
        components.URLRelativeToURL @base_url
      end
      
      def set_headers(request, headers)
        headers.each do |name, value|
          request.addValue value.to_s, forHTTPHeaderField: name.to_s
        end
      end
      
      def set_body(request, params)
        data = json_params(params)
        request.setHTTPBody(data)
      end
      
      def json_params(params)
        NSJSONSerialization.dataWithJSONObject(params, options: 0, error: nil)
      end
      
      def create_task(request, &block)
        if block_given?
          session.dataTaskWithRequest(request, completionHandler: -> (data, response, error) {
            block.call(APIResponse.new(data, response, error))
          })
        else
          session.dataTaskWithRequest(request)
        end
      end
      
      class APIResponse
        attr_reader :success, :data, :error, :response

        def initialize(data, response, error)
          @success = (200...300).include?(response.statusCode) if response
          @data = NSJSONSerialization.JSONObjectWithData(data, options: 0, error: nil)
          @response = response
          @error = error
        end

        def success?
          @success
        end
      end
    end
  end
end