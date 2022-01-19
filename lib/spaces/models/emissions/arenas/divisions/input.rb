module Arenas
  class Input < ::Divisions::Input

    class << self
      def default_struct
        OpenStruct.new(
          volumes: OpenStruct.new(volume_map),
          providers: OpenStruct.new(provider_role_map)
        )
      end

      def volume_map
        {
          path: '/var/lib/engines/volumes'
        }
      end

      def provider_role_map
        {
          packing: [:docker],
          provisioning: [:docker_compose, :terraform],
          runtime: [:docker]
        }
      end
    end

  end
end
