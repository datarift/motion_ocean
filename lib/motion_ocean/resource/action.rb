module MotionOcean
  module Resource
    class Action
      include Resource::Base
      
      def all(&block)
        get('actions', &block)
      end
      
      def show(action_id, &block)
        get("actions/#{action_id}", &block)
      end
    end
  end
end