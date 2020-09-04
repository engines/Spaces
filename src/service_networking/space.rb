require_relative '../spaces/subspace'
require_relative '../defaultables/space'
require_relative 'service_network'
require_relative 'consul/consul'

module ServiceNetworking
  class Space < ::Spaces::Subspace
    include Defaultables::Space

    class << self
      def default_model_class
        ServiceNetwork
      end
    end

    def load(type)
      require_relative("#{type}/#{type}")
    end

    def default_specific_class; Consul::Consul ;end

  end
end
