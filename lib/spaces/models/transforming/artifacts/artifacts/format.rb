require_relative 'artifact'

module Artifacts
  class Format < Artifact

    class << self
      def dynamic_type(stanza) =
        class_for(stanza).new(stanza)

      def class_for(stanza) = super(
        :artifacts, stanza.provider.identifier, stanza.compute_qualifier, :formats, stanza.qualifier
      )
    end

    def type_for(key) = mapping.value(key)

    def resource_type_map = mapping.type_map
    def mapping = resource_type_map_class.new
    def resource_type_map_class = ResourceTypeMap

  end
end
