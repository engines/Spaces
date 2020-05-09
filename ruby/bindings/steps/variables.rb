require_relative '../../docker/files/step'

module Bindings
  module Steps
    class Variables < Docker::Files::Step

      def instructions
        context.override_keys.map do |k|
          "ENV #{context.identifier}_#{k} '#{context.variables[k]}'"
        end
      end

    end
  end
end
