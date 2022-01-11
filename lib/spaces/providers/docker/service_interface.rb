module Providers
  module Docker
    class ServiceInterface < Interface

      alias_method :service, :emission

      def execute_all_for(milestone_name)
        service.commands_for(milestone_name).map do |c|
          container.exec(c)
        end
      end

      def container
        @container ||= bridge.get(container_identifier)
      end

      def container_identifier
        "#{service.identifier.gsub(identifier_separator, separator)}_1" #FIX: !!! hardcoded suffix!
      end

      def bridge; ::Docker::Container ;end
      def identifier_separator; service.identifier_separator ;end
      def separator; '_' ;end

    end
  end
end
