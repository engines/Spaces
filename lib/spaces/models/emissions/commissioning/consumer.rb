module Commissioning
  class Consumer < ::Resolving::Emission

    class << self
      def composition_class = Composition
    end

    delegate(
      [:connections_down, :commission] => :resolution,
      ip_address: :commission
    )

    def service_identifiers_for(name) =
      milestones_for(name).map(&:service_identifier).uniq

    def milestones_for(name) =
      milestones.select { |m| m.name == name.to_s }

    def the_milestones = settled_resolution ? _the_milestones : []

    def settled_resolution = resolutions.exist_then_by(identifier)

    def _the_milestones
      connections_down.map do |c|
        c.as_service_for(self).struct.milestones
      end.flatten
    end

  end
end
