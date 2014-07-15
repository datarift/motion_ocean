module MotionOcean
  module Resource
    class Domain
      include Resource::Base
      
      def create(options, &block)
        post('domains', options, &block)
      end
      
      def all(&block)
        get('domains', &block)
      end
      
      def show(domain_name, &block)
        get("domains/#{domain_name}", &block)
      end
      
      def destroy(domain_name, &block)
        delete("domains/#{domain_name}", &block)
      end
      
      def create_record(domain_name, options, &block)
        post("domains/#{domain_name}/records", options, &block)
      end
      
      def records(domain_name, &block)
        get("domains/#{domain_name}/records", &block)
      end
      
      def show_record(domain_name, record_id, &block)
        get("domains/#{domain_name}/records/#{record_id}", &block)
      end
      
      def update_record(domain_name, record_id, options, &block)
        put("domains/#{domain_name}/records", options, &block)
      end
      
      def destroy_record(domain_name, record_id, &block)
        delete("domains/#{domain_name}/records", &block)
      end
    end
  end
end