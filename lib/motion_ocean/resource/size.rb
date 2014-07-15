module MotionOcean
  module Resource
    class Size
      include Resource::Base
      
      def all(&block)
        get('sizes', &block)
      end
    end
  end
end