require_relative '../../docker/files/step'

module Bindings
  module Steps
    class Persistence < Docker::Files::Step

      def product
        context.scripts.map { |s| "RUN #{s.path}" }
      end

    end
  end
end
