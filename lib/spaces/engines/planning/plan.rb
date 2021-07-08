require_relative 'status'

module Planning
  class Plan < Emissions::Emission

    class << self
      def composition_class; Composition ;end
    end

    def keys; composition.keys ;end

  end
end
