module Commissioning
  class Consumer < ::Resolving::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(connections_down: :resolution)

    def the_milestones
      connections_down.map do |c|
        c.as_service.struct.milestones
      end.flatten
    end

  end
end
