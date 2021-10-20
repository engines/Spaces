module Packing
  class Pack < ::Resolving::Emission

    class << self
      def composition_class; Composition ;end
    end

    alias_method :context_identifier, :identifier

  end
end
