require_relative '../../docker/files/step'

module Respositories
  module Steps
    class RunScripts < Docker::Files::Step

      def product
        context.scripts.map { |s| "RUN #{s.path}" }
      end

    end
  end
end
