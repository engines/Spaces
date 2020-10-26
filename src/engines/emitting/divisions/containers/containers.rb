module Divisions
  class Containers < ::Emissions::SubclassDivisible

    def provisioning_stanzas
      [super, dns.provisioning_stanzas]
    end

    def dns
      @dns ||= dns_class.prototype(emission: emission, label: :dns)
    end

    def dns_class; ::Associations::Dns ;end

  end
end
