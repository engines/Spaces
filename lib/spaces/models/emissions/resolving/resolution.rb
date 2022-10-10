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
      def composition_class = Composition
    end

    delegate(
      [:packs, :orchestrations, :registry] => :universe
    )

    def resourcer? = only_defines?(:resources)

    def complete? = all_complete?(divisions)

    def image = images&.first

    def image_identifier = image&.output_identifier

    def provides_compute_service_for?(identifier) =
      compute_service_identifiers&.include?(identifier.to_sym)

    def compute_service_identifiers =
      compute_service&.identifiers || []

    def compute_service = division_map[:compute_service]

    def direct_connections = connect_bindings.map(&:resolution).compact

    def division_map
      @division_map ||= super.tap do |d|
        d[:deployment] ||= division_for(:deployment)
      end
    end

  end
end
