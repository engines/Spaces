module Arenas
  class Input < ::Divisions::Input

    class << self
      def default_struct
        OpenStruct.new(provider_role_map)
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
