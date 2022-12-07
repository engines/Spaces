require_relative 'artifact'

module Artifacts
  module Stanzas
    class Stanza < Artifact

      alias_method :artifact, :holder

      def snippets = format.content

      def format
        @format ||= Format.dynamic_type(self)
      end

      def resource_type_map = resource_type_map_class.new.type_map
      def resource_type_map_class = ResourceTypeMap

      def method_missing(m, *args, &block)
        return artifact.send(m, *args, &block) if artifact.respond_to?(m)
        super
      end

      def respond_to_missing?(m, *)
        artifact.respond_to?(m) || super
      end

    end
  end
end
