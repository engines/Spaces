module Providers
  module Packer
    class OtherPackage < ::Adapters::OtherPackage

      def packing_stanza
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
