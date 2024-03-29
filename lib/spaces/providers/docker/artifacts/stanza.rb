module Artifacts
  module Docker
    module Stanzas
      class Stanza < ::Artifacts::Stanzas::Stanza

        delegate script_path: :division

        def snippets = snippets.compact.join("\n")

        def auxiliary_file_snippet_for(path)
          "ADD #{script_path}/ #{temporary_script_path}/" if path.basename.to_s == 'packing'
        end

        def file_copy_snippet_for(directory, precedence) =
          "ADD #{directory}/#{precedence}/ /"

      end
    end
  end
end
