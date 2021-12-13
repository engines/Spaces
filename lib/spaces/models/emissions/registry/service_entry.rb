module Registry
  class ServiceEntry < ::Resolving::Emission

    class << self
      def composition_class; ServiceComposition ;end
    end

    delegate(registry: :resolution)

    def initialize(identifiable:)
      super.tap do
        self.struct = OpenStruct.new(life_cycle_milestones: registry.life_cycle_milestones_for(identifiable))
      end
    end

  end
end
