module MotionOcean
  module Resource
    class Region
      include Resource::Base
      
      def all(&block)
        get('regions', &block)
      end
    end
  end
end