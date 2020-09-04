require_relative '../spaces/subspace'
require_relative '../defaultables/space'
require_relative 'dns'
require_relative 'power_dns/power_dns'

module Dns
  class Space < ::Spaces::Subspace
    include Defaultables::Space

    class << self
      def default_model_class
        Dns
      end
    end

    def load(type)
      require_relative("#{type}/#{type}")
    end

    def default_specific_class; PowerDns::PowerDns ;end

  end
end
