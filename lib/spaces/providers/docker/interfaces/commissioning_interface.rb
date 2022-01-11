require_relative 'container_interface'

module Providers
  module Docker
    class CommissioningInterface < ContainerInterface

      alias_method :commission, :emission

    end
  end
end
