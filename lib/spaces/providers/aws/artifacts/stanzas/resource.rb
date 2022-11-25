module Artifacts
  module Aws
    class ResourceStanza < Stanza

      class << self
        def resource_type_map = {}
      end

      delegate resource_type_map: :klass

      alias_method :resource, :holder

      def resource_identifier = [arena.identifier, resource.identifier, resource_type].join('_').abbreviated_to(maximum_identifier_length)

      def resource_type_here =
        resource_type_map[resource_type.to_sym] || resource_type

      def configuration
        @configuration ||= default_configuration.merge(more_configuration).merge(resource.configuration)
      end

      def resource_type = resource.type

    end
  end
end
