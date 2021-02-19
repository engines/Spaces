module Divisions
  class Containers < ::Divisions::SubclassDivisible

    def dns
      @dns ||= dns_class.prototype(emission: emission, label: :dns)
    end

    def dns_class; ::Divisions::Dns ;end

  end
end
