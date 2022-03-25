require_relative 'capsule_interface'

module Providers
  module Docker
    class CommissionInterface < CapsuleInterface

      alias_method :commission, :emission

      #-------------------------------------------------------------------------

      def container
        @container ||= bridge.get(container_identifier)
      end

      def container_identifier
        "#{commission.identifier.gsub(commission.identifier_separator, '_')}_1"
      end

      #-------------------------------------------------------------------------

    end
  end
end
