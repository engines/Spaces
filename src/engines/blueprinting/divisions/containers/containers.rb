module Divisions
  class Containers < ::Emissions::SubclassDivisible

    def dns
      @dns ||= dns_class.prototype(emission: emission, label: :dns)
    end

    def dns_class; ::Associations::Dns ;end

  end
end
