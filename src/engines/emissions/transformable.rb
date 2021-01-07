module Emissions
  class Transformable < ::Spaces::Model

    class << self
      def auxiliary_directories = [:packing, :commissioning]
    end

    delegate(
      mandatory_keys: :composition,
      auxiliary_directories: :klass
    )

    def complete? = true

    def identifier = struct[:identifier]

    def descriptor_class = ::Spaces::Descriptor

    def arena_stanzas = stanzas_for(:arena)
    def provisioning_stanzas = stanzas_for(:provisioning)

    def stanzas_for(symbol) = _stanzas_for(symbol)

    def random(length) = SecureRandom.hex(length.to_i)

    protected

    def all_complete?(array) = array.map(&:complete?).all_true?

    private

    def _stanzas_for(symbol)
      raise TransformableWithoutStanzaError
    rescue TransformableWithoutStanzaError => e
      warn(error: e, method: "#{symbol}_stanzas", klass: klass, verbosity: [:silence])
      []
    end

  end
end


class TransformableWithoutStanzaError < StandardError
end
