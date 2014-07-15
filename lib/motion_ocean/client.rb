module MotionOcean
  class Client
    attr_accessor :access_token

    attr_reader :action
    attr_reader :domain
    attr_reader :droplet
    attr_reader :image
    attr_reader :key
    attr_reader :region
    attr_reader :size
    
    DEFAULT_OPTIONS = {}
    DIGITAL_OCEAN_URL = 'https://api.digitalocean.com/v2'
    
    def initialize(options = DEFAULT_OPTIONS)
      self.access_token = options.fetch(:access_token, nil)
      yield(self) if block_given?
      fail ArgumentError, 'missing access token' unless access_token
      initialize_resources
    end
    
    private
    def initialize_resources
      @action  = Resource::Action.new(api_client)
      @domain  = Resource::Domain.new(api_client)
      @droplet = Resource::Droplet.new(api_client)
      @region  = Resource::Region.new(api_client)
      @size    = Resource::Size.new(api_client)
    end
    
    def api_client
      @api_client ||= AFMotion::SessionClient.build(DIGITAL_OCEAN_URL) do |client|
        client.session_configuration :default
        
        client.header 'Accept', 'application/json'
        client.header 'Content-Type', 'application/json'
        client.header 'Authorization', "Bearer #{access_token}"
        
        client.request_serializer :json
        client.response_serializer :json
      end
    end
  end
end