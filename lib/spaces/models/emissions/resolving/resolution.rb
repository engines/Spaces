require_relative 'summary'

module Resolving
  class Resolution < ::Settling::Settlement
    include Registering
    include Packing
    include Provisioning
    include Imaging
    include Capsules
    include Commissioning
    include Consuming
    include Servicing
    include ::Resolving::Summary

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:packs, :provisioning, :registry] => :universe
    )

    def configuration
      binding_target&.struct&.configuration
    end

    def complete?
      all_complete?(divisions)
    end

    def image
      images&.first
    end

    def direct_connections
      connect_bindings.map(&:resolution).compact
    end

    def division_map
      @division_map ||= super.tap do |d|
        d[:deployment] ||= division_for(:deployment)
      end
    end

  end
end
