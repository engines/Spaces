require_relative 'interface'

module Providers
  module Docker
    class PackingInterface < ImagingInterface

      relation_accessor :pack

      def build
        pack.copy_auxiliaries
        build_from_pack
        pack.remove_auxiliaries
      end

      def build_from_pack
        with_streaming(pack, :build) do
          build_from_dir.tap { |i| tag_latest(i) }
        rescue ::Docker::Error::ImageNotFoundError => e
          # Do nothing: ignore any ImageNotFoundError.
        end
      end

      def build_from_dir
        stream.output("\n")
        bridge.build_from_dir("#{path_for(pack)}") do |encoded|
          process_output(encoded)
        end
      end

      def stream
        stream_for(pack, :build)
      end

      def initialize(pack)
        self.pack = pack
      end

    end
  end
end
