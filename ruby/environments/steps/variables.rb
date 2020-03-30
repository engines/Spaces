require_relative '../../docker/files/step'

module Environments
  module Steps
    class Variables < Docker::Files::Step

      def product
        variables.map { |v| "ENV #{v.name} '#{v.value}'" }
      end

      def variables
        @variables ||= context.variables || []
      end

    end
  end
end
