module MotionOcean
  module Resource
    class Key
      include Resource::Base

      def create(options, &block)
        post('account/keys', options.to_json)
      end

      def all(&block)
        get('account/keys', &block)
      end

      def show(key_id, &block)
        get("account/keys/#{key_id}", &block)
      end

      def update(key_id, options, &block)
        put("account/keys/#{key_id}", options.to_json, &block)
      end

      def destroy(key_id, &block)
        delete("account/keys/#{key_id}", &block)
      end
    end
  end
end