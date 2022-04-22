require_relative 'image_interface'

module Providers
  module Docker
    class PackInterface < ImageInterface

      alias_method :pack, :emission

      delegate(
        packs: :universe,
        path_for: :packs
      )

      def build
        pack.copy_auxiliaries
        build_from_pack
        pack.remove_auxiliaries
      end

      def build_from_pack
        with_streaming(streaming_args) do
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

      def stream; stream_for(streaming_args) ;end
      def streaming_args; [:packs, pack, :build] ;end

    end
  end
end
