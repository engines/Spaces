require_relative 'requires'

module Bindings
  module Steps
    class Variables < Docker::Files::Step

      def product
        context.keys.map do |k|
          "ENV #{context.name}_#{k} '#{context.resolved[k]}'"
        end
      end

    end
  end
end
