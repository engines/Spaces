require_relative 'image_interface'

module Providers
  module Docker
    class PackingInterface < ImageInterface

      alias_method :pack, :emission

      def create
        bridge.create(name: output_image_identifier)
      end

      def build
        space.copy_auxiliaries_for(pack)
        build_from_pack
        space.remove_auxiliaries_for(pack)
      end

      def build_from_pack
        with_streaming(pack, :build) do
          build_from_dir.tap { |image| tag_latest(image) }
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

      def process_output(encoded)
        # FIX ME! The rescue is needed due to JSON parse errors
        output = JSON.parse(encoded, symbolize_names: true)
        stream.error("#{output[:error]}\n") if output[:error]
        stream.output(output[:stream]) if output[:stream]
      rescue
        stream.output("Failed to parse JSON: #{encoded}\n")
      end

      def stream
        stream_for(pack, :build)
      end

    end
  end
end
