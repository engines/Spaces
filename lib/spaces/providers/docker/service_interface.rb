module Providers
  module Docker
    class ServiceInterface < Interface

      alias_method :service, :emission

      def execute_all_for(milestone_name)
        commands_for(milestone_name).map do |c|
          container.exec(c)
        end
      end

      def commands_for(milestone_name)
        service.milestones_for(milestone_name).map(&:command_line)
      end

      def container
        @container ||= bridge.get(service_identifier)
      end

      def bridge; ::Docker::Container ;end

    end
  end
end
