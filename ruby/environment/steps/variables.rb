require_relative 'requires'

module Environment
  class Environment
    class Variables < Container::Docker::Step

      def content
        variables.map { |v| "ENV #{v.name} '#{v.value}'" }
      end

      def variables
        @variables ||= context.struct.variables || []
      end

    end
  end
end
