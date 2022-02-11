module Commissioning
  class Consumer < ::Resolving::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(connections_down: :resolution)

    def service_identifiers_for(name)
      milestones_for(name).map(&:service_identifier).uniq
    end

    def milestones_for(name)
      milestones.select { |m| m.name == name.to_s }
    end

    def the_milestones
      connections_down.map do |c|
        c.as_service_for(self).struct.milestones
      end.flatten
    end

  end
end
