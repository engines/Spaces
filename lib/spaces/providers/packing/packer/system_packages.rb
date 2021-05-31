module Providers
  class Packer < ::Providers::Provider
    class SystemPackages < ::Providers::SystemPackages

      delegate temporary_script_path: :division

      def packing_artifact_for(key)
        {
          type: 'shell',
          environment_vars: "SYSTEM_PACKAGE_#{key.upcase}=#{division.send(key)&.join(' ')}",
          inline: ["#{temporary_script_path}/#{qualifier}/#{key}"]
        }
      end

    end
  end
end
