require_relative 'container_interface'

module Providers
  module Docker
    class CommissioningInterface < ContainerInterface

      relation_accessor :resolving_emission

      def initialize(resolving_emission)
        self.resolving_emission = resolving_emission
      end

    end
  end
end
