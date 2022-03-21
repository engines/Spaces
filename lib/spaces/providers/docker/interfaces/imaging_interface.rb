require_relative 'interface'

module Providers
  module Docker
    class ImagingInterface < Interface

      alias_method :pack, :emission

      delegate(
        prune: :bridge,
        [:connection, :version, :info, :default_socket_url] => :klass,
      )

      def pull
        bridge.create(fromImage: output_image_identifier)
      end

      alias_method :import, :pull

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
          build_from_dir.tap { |i| tag_latest(i) }
        rescue ::Docker::Error::ImageNotFoundError => e
          # Do nothing: ignore any ImageNotFoundError.
        end
      end

      def tag_latest(image)
        image.tag('repo' => pack.output_identifier, 'force' => true, 'tag' => 'latest')
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

      def bridge; ::Docker::Image ;end
      def model_class; Image ;end
      def file_class; Files::File ;end

    end
  end
end
