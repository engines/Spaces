require_relative 'status'

module Registry
  class Entry < Emissions::Emission

    class << self
      def composition_class; Composition ;end
    end

    def keys; composition.keys ;end

  end
end
