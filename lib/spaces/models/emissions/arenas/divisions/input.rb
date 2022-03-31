module Arenas
  class Input < ::Divisions::Input

    class << self
      def default_struct
        OpenStruct.new(
          volumes: OpenStruct.new(volume_map)
        )
      end

      def volume_map
        {
          path: '/var/lib/engines/volumes'
        }
      end
    end

  end
end
