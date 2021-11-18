module Packing
  class Pack < ::Resolving::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(output_identifier: :image)

    alias_method :context_identifier, :identifier

  end
end
