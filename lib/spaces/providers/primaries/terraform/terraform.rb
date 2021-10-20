module Providers
  module Terraform
    class Terraform < ::Providers::Provider

      def provider_role_map
        @provider_role_map ||= {
          dns: [:power_dns]
        }
      end

      def dns_provider; provider_for(:dns) ;end
      def dns_qualifier; dns_provider.qualifier ;end

    end
  end
end
