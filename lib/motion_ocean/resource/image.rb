module MotionOcean
  module Resource
    class Image
      include Resource::Base

      def all(&block)
        get('images', &block)
      end

      def show(image_id, &block)
        get("images/#{image_id}", &block)
      end

      def update(image_id, options, &block)
        put("images/#{image_id}", options.to_json, &block)
      end

      def destroy(image_id, &block)
        delete("images/#{image_id}", &block)
      end

      def transfer(image_id, region, &block)
        action(image_id, __method__, region: region, &block)
      end

      def show_action(image_id, action_id, &block)
        get("images/#{image_id}/actions/#{action_id}", &block)
      end

      private

      def action(image_id, type, params = {}, &block)
        post("images/#{image_id}/actions",
             { type: type }.merge(params).to_json, &block)
      end
    end
  end
end