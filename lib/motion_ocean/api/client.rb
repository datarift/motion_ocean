module MotionOcean
  module API
    class Client
      attr_reader :base_url
      
      def initialize(base_url, &block)
        base_url += '/' unless base_url.end_with? '/'
        @base_url = NSURL.URLWithString(base_url)
        @headers = []
      
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
    
      def get(path, &block)
        request = create_request(path, :get)
        create_task(request, &block).resume
      end
    
      def delete(path, &block)
        request = create_request(path, :get)
        create_task(request, &block).resume
      end
      
      def post(path, params, &block)
        request = create_request(path, :post)
        add_params(request, params)
        create_task(request, &block).resume
      end
    
      def put(path, params, &block)
        request = create_request(path, :post)
        add_params(request, params)
        create_task(request, &block).resume
      end
    
      def head(path, params = {}, &block)
        request = create_request(path, :post)
        add_params(request, params)
        create_task(request, &block).resume
      end
      
      def header(name, value)
        @headers << { name: name, value: value }
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
    
      def create_request(path, method)
        url = NSURL.URLWithString(path, relativeToURL: @base_url)
        
        request = NSMutableURLRequest.requestWithURL(url)
        
        @headers.each do |header|
          request.addValue header[:value], forHTTPHeaderField: header[:name]
        end
        
        request.setHTTPMethod(method.to_s.upcase)
        
        request
      end
      
      def add_params(request, params)
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
        attr_reader :success, :data, :error

        def initialize(data, response, error)
          @success = (200...300).include?(response.statusCode)
          @data = NSJSONSerialization.JSONObjectWithData(data, options: 0, error: nil)
          @error = error
        end

        def success?
          @success
        end
      end
    end
  end
end