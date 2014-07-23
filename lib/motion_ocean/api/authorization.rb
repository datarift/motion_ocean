module MotionOcean
  module API
    class Authorization
      class << self
        def build(options = {})
          username, password = options.values_at :username, :password
          token = options.fetch(:token, nil)
          token_name = options.fetch(:token_name, "Token")
      
          if username && password
            http_basic_header(username, password)
          elsif token
            token_header(token, token_name)
          else
            nil
          end
        end
    
        def http_basic_header(username, password)
          token_data = "#{username}:#{password}".dataUsingEncoding(NSUTF8StringEncoding)
          token_header(token_data.base64Encoding, "Basic")
        end
        
        def token_header(token, token_name)
          "#{token_name} #{token}"
        end
      end
    end    
  end
end