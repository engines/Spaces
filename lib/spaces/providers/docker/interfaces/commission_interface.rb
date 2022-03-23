require_relative 'container_interface'

module Providers
  module Docker
    class CommissionInterface < ContainerInterface

      relation_accessor :resolving_emission

      #-------------------------------------------------------------------------

      def container
        @container ||= bridge.get(container_identifier)
      end

      def container_identifier
        "#{resolving_emission.identifier.gsub(resolving_emission.identifier_separator, '_')}_1"
      end

      #-------------------------------------------------------------------------

      def initialize(resolving_emission)
        self.resolving_emission = resolving_emission
      end

    end
  end
end
