module Providers
  module Docker
    class Stanza < ::Artifacts::Stanza

      delegate script_path: :division

      def snippets; snippets.compact.join("\n") ;end

      def auxiliary_file_snippet_for(path)
        "ADD #{script_path}/ #{temporary_script_path}/" if path.basename.to_s == 'packing'
      end

      def file_copy_snippet_for(folder, precedence)
        "ADD #{folder}/#{precedence}/ /"
      end

    end
  end
end
