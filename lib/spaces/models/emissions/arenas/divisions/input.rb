module Arenas
  class Input < ::Divisions::Input

    class << self
      def default_struct
        OpenStruct.new(volume_map.merge(provider_role_map))
      end

      def volume_map
        {
          volumes: {
            path: '/var/lib/engines/volumes'
          }
        }
      end

      def provider_role_map
        {
          providers: {
            packing: [:docker],
            provisioning: [:docker_compose, :terraform],
            runtime: [:docker]
          }
        }
      end
    end

  end
end
