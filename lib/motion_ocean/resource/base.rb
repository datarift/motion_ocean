module MotionOcean
  module Resource
    module Base
      attr_reader :api_client
      
      PER_PAGE = 200
      
      def initialize(api_client)
        @api_client = api_client
      end
      
      private
      [:delete, :get, :head, :post, :put].each do |verb|
        define_method verb do |url, options = {}, &block|
          request(__method__, url, options, &block)
        end
      end
      
      def request(verb, url, options, &block)
        opts = {}
        opts = { per_page: PER_PAGE } if verb == :get
        options = opts.merge(options)
        
        api_client.public_send(verb, url, options, &block)
      end
    end
  end
end