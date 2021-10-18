module Providers
  module Terraform
    class Terraform < ::Providers::Provider
      include ::Engines::Prerequisites

        def prerequisite_role_map
          @prerequisite_map ||= {
            dns: [:power_dns]
          }
        end

        def dns_prerequisite; prerequisite_for(:dns) ;end
        def dns_qualifier; dns_prerequisite.qualifier ;end

    end
  end
end
