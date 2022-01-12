module Providers
  module Docker
    class PackingInterface < Interface

      alias_method :pack, :emission

      delegate(
        [:all, :get, :prune] => :bridge,
        [:connection, :version, :info, :default_socket_url] => :klass,
      )

      def create
        bridge.create(name: output_image_identifier)
      end

      def pull
        bridge.create(fromImage: output_image_identifier)
      end

      alias_method :import, :pull

      def all(options = {})
        bridge.all(options.reverse_merge(all: true))
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

      def stream
        stream_for(pack, :build)
      end

      def tag_latest(image)
        image.tag('repo' => pack.output_identifier, 'force' => true, 'tag' => 'latest')
      end

      def bridge; ::Docker::Image ;end
      def file_class; Files::File ;end

    end
  end
end
