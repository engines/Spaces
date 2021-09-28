module Providers
  module Packer
    class OtherPackage < ::ProviderAspects::OtherPackage

      def packing_artifact
        {
          type: 'shell',
          environment_vars: environment_vars,
          inline: ["#{temporary_script_path}/#{qualifier}/add"]
        }
      end

      def environment_vars
        [:repository, :extraction, :extracted_path, :destination].map do |v|
          "#{v}=#{division.send(v) if division.respond_to?(v)}"
        end
      end

    end
  end
end
