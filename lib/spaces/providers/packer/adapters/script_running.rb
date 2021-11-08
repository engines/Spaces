module Adapters
  module Packer
    class ScriptRunning < ::Adapters::ScriptRunning

      def snippets_for(precedence)
        {
          type: 'shell',
          inline: scripts_for(precedence).map do |s|
            temporary_script_path.join("#{precedence}", s)
          end
        }
      end

    end
  end
end
