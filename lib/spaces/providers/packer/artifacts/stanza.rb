module Providers
  module Packer
    class Packers < ::Artifacts::Stanza

      delegate [:snippets, :auxiliary_directories, :source_path_for, :copy_source_path_for] => :division

      def snippets; snippets.compact.map(&:to_h) ;end

      def auxiliary_file_snippet_for(path)
        {
          type: 'file',
          source: "#{path}/",
          destination: 'tmp'
        }
      end

      def file_copy_snippet_for(folder, precedence)
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
