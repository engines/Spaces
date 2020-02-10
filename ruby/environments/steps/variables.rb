require_relative 'requires'

module Environments
  module Steps
    class Variables < Docker::Files::Step

      def content
        variables.map { |v| "ENV #{v.name} '#{v.value}'" }
      end

      def variables
        @variables ||= context.variables || []
      end

    end
  end
end
