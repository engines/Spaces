module Providers
  class Packer < ::ProviderAspects::Provider
    class Scripts < ::ProviderAspects::Scripts

      delegate scripts_for: :division


      def packing_artifact_for(precedence)
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
