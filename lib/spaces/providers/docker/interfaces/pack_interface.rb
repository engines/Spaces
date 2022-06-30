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
        build_from_dir.tap { |i| tag_latest(i) }
      rescue ::Docker::Error::ImageNotFoundError => e
        # Do nothing: ignore any ImageNotFoundError.
        # Docker should get image from remote repository.
      end

      def build_from_dir
        bridge.build_from_dir("#{path_for(pack)}") do |encoded|
          process_output(encoded)
        end
      end

    end
  end
end
