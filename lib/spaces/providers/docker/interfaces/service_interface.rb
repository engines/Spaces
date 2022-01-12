require_relative 'container_interface'

module Providers
  module Docker
    class ServiceInterface < ContainerInterface

      alias_method :service, :emission

      def execute_commands_for(milestone_name)
        service.commands_for(milestone_name).map do |c|
          container.exec(c)
        end
      end

    end
  end
end
