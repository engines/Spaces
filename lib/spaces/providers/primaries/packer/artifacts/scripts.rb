module Providers
  module Packer
    class Scripts < ::Artifacts::Scripts

      delegate scripts_for: :division


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
