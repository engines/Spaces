module Providers
  class Packer < ::Providers::Provider
    class Packers < ::Providers::Packers

      delegate [:packing_artifacts, :auxiliary_folders, :source_path_for, :copy_source_path_for] => :division

      def packing_artifact; packing_artifacts.map(&:to_h) ;end

      def auxiliary_file_artifact_for(path)
        {
          type: 'file',
          source: "#{path}/",
          destination: 'tmp'
        }
      end

      def file_copy_artifact_for(folder, precedence)
        {
          type: 'shell',
          inline: [
            "chown -R root:root /tmp/#{folder}/#{precedence}/",
            "tar -C /tmp/#{folder}/#{precedence}/ -cf - . | tar -C / -xf -"
          ]
        }
      end

    end
  end
end
