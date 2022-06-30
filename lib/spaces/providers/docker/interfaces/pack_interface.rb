require_relative 'image_interface'

module Providers
  module Docker
    class PackInterface < ImageInterface

      alias_method :pack, :emission

      delegate(
        packs: :universe,
        path_for: :packs,
        [:packing_compute_provider, :packing_compute_respository_path] => :arena
      )

      def build
        pack.copy_auxiliaries
        build_from_pack
        pack.remove_auxiliaries
      end

      def build_from_pack
        build_from_dir.tap do |i|
          if packing_compute_provider
            i.tag(repo: packing_compute_respository_path, tag: pack.output_identifier, force: true)
          else
            i.tag(repo: pack.output_identifier, tag: default_tag, force: true)
          end
        end
      rescue ::Docker::Error::ImageNotFoundError => e
        # Do nothing: ignore any ImageNotFoundError.
      end

      def build_from_dir
        stream&.output("\n")
        bridge.build_from_dir("#{path_for(pack)}") do |encoded|
          process_output(encoded)
        end
      end

      def default_tag; :latest ;end

    end
  end
end
