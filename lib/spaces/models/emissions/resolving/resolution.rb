require_relative 'summary'

module Resolving
  class Resolution < ::Settling::Settlement
    include Registering
    include Packing
    include Orchestrating
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
      [:packs, :orchestrations, :registry] => :universe
    )

    def resourcer?; only_defines?(:resources) ;end

    def complete?
      all_complete?(divisions)
    end

    def image
      images&.first
    end

    def image_identifier
      image&.output_identifier
    end

    def provides_compute_service_for?(identifier)
      compute_service_identifiers&.include?(identifier.to_sym)
    end

    def compute_service_identifiers
      compute_service&.identifiers || []
    end

    def compute_service
      division_map[:compute_service]
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
