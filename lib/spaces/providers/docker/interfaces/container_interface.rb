require_relative 'interface'

module Providers
  module Docker
    class ContainerInterface < Interface

      def execute(command)
        container.send(command)
      end

      def state
        container.info['State'].transform_keys { |k| k.snakize.to_sym }
      end

      def network
        # TODO: revise hackiness -- assumes the first value is the only or best
        container.info['NetworkSettings']['Networks'].values.first.transform_keys { |k| k.snakize.to_sym }
      end

      def container
        @container ||= bridge.get(container_identifier)
      end

      def container_identifier
        "#{emission.identifier.gsub(emission.identifier_separator, separator)}_1" #FIX: !!! hardcoded suffix!
      end

      def bridge; ::Docker::Container ;end
      def separator; '_' ;end

    end
  end
end
