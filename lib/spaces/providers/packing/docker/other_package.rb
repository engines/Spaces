module Providers
  class Docker < ::ProviderAspects::Provider
    class OtherPackage < ::ProviderAspects::OtherPackage

     def packing_artifact
        "RUN #{temporary_script_path}/#{qualifier}/add #{quoted_environment_vars.join(' ')}"
      end

      def quoted_environment_vars
        environment_vars.map { |v| %("#{v}")}
      end

      def environment_vars
        [:repository, :extraction, :extracted_path, :destination].map do |v|
          division.send(v) if division.respond_to?(v)
        end
      end

    end
  end
end
