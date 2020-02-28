require_relative 'requires'

module Blueprints
  module Steps
    class Variables < Docker::Files::Step

      def content
        context.resolved.keys.map do |k|
          "ENV #{context.name}_#{k} '#{context.resolved[k]}'"
        end
      end

    end
  end
end
