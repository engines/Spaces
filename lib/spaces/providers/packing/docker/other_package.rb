module Providers
  class Docker < ::ProviderAspects::Provider
    class OtherPackage < ::ProviderAspects::OtherPackage

     def packing_artifact
        "RUN #{temporary_script_path}/#{qualifier}/add #{environment_vars.in_quotes.join(' ')}"
      end

      def environment_vars
        [:repository, :extraction, :extracted_path, :destination].map do |v|
          division.send(v) if division.respond_to?(v)
        end
      end

    end
  end
end
