module MotionOcean
  module Resource
    class Droplet
      include Resource::Base
      
      def create(options, &block)
        post('droplets', options, &block)
      end
      
      def all(&block)
        get('droplets', &block)
      end
      
      def show(droplet_name, &block)
        get("droplets/#{droplet_name}", &block)
      end
      
      def destroy(droplet_name, &block)
        delete("droplets/#{droplet_name}", &block)
      end
      
      def backups(droplet_id, &block)
        get("droplets/#{droplet_id}/backups", &block)
      end

      def kernels(droplet_id, &block)
        get("droplets/#{droplet_id}/kernels", &block)
      end

      def snapshots(droplet_id, &block)
        get("droplets/#{droplet_id}/snapshots", &block)
      end
      
      def rename(droplet_id, name, &block)
        action(droplet_id, __method__, name: name, &block)
      end

      def reboot(droplet_id, &block)
        action(droplet_id, __method__, &block)
      end

      def shutdown(droplet_id, &block)
        action(droplet_id, __method__, &block)
      end

      def power_off(droplet_id, &block)
        action(droplet_id, __method__, &block)
      end

      def power_cycle(droplet_id, &block)
        action(droplet_id, __method__, &block)
      end

      def power_on(droplet_id, &block)
        action(droplet_id, __method__, &block)
      end

      def resize(droplet_id, size, &block)
        action(droplet_id, __method__, size: size, &block)
      end

      def rebuild(droplet_id, image_id, &block)
        action(droplet_id, __method__, image: image_id, &block)
      end

      def restore(droplet_id, image_id, &block)
        action(droplet_id, __method__, image: image_id, &block)
      end

      def password_reset(droplet_id, &block)
        action(droplet_id, __method__, &block)
      end

      def change_kernel(droplet_id, kernel_id, &block)
        action(droplet_id, __method__, kernel: kernel_id, &block)
      end

      def enable_ipv6(droplet_id, &block)
        action(droplet_id, __method__, &block)
      end

      def disable_backups(droplet_id, &block)
        action(droplet_id, __method__, &block)
      end

      def enable_private_networking(droplet_id, &block)
        action(droplet_id, __method__, &block)
      end

      def actions(droplet_id, &block)
        get("droplets/#{droplet_id}/actions", &block)
      end

      def show_action(droplet_id, action_id, &block)
        get("droplets/#{droplet_id}/actions/#{action_id}", &block)
      end
      
      private

      def action(droplet_id, type, params = {}, &block)
        post("droplets/#{droplet_id}/actions",
             { type: type }.merge(params).to_json, &block)
      end
    end
  end
end