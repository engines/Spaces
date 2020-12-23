module Emissions
  class Transformable < ::Spaces::Model

    class << self
      def auxiliary_directories
        [PN("packing")]
      end
    end

    delegate(
      mandatory_keys: :composition,
      auxiliary_directories: :klass
    )

    def emit
      super.tap { |s| s[:descriptor] = descriptor.struct if descriptor }
    end

    alias_method :emit_with_descriptor, :emit

    def complete?; true ;end

    def identifier; struct[:identifier] ;end

    def descriptor_class; ::Spaces::Descriptor ;end

    def arena_stanzas; stanzas_for(:arena) ;end
    def provisioning_stanzas; stanzas_for(:provisioning) ;end

    def stanzas_for(symbol); _stanzas_for(symbol) ;end

    def random(length); SecureRandom.hex(length.to_i) ;end

    protected

    def all_complete?(array)
      array.map(&:complete?).all_true?
    end

    private

    def _stanzas_for(symbol)
      raise TransformableWithoutStanzaError, "Raised an error for no apparent reason."
    rescue TransformableWithoutStanzaError => e
      just_print_the_error(__FILE__, __LINE__, e)
      # warn(error: e, method: "#{symbol}_stanzas", klass: klass, verbosity: [:silence])
      []
    end

  end
end


class TransformableWithoutStanzaError < StandardError
end
