module Providers
  module Packer
    class Scripts < ::ProviderAspects::Scripts

      delegate scripts_for: :division


      def packing_stanza_for(precedence)
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
