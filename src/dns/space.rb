require_relative '../spaces/subspace'
require_relative '../defaultables/space'
require_relative 'dns'
require_relative 'power_dns/power_dns'

module DNS
  class Space < ::Spaces::Subspace
    include Defaultables::Space

    class << self
      def default_model_class
        DNS
      end
    end

    def load(type)
      require_relative("#{type}/#{type}")
    end

    def default
      @default ||= default_dns_class.new.tap do |m|
        m.struct = m.default
      end
    end

    def default_dns_class; PowerDNS::PowerDNS ;end

  end
end
