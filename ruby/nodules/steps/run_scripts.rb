require_relative '../../docker/files/step'

module Nodules
  class Nodules < ::Spaces::Product
    class RunScripts < Docker::File::Step

      def content
        context.scripts.flatten.map { |s| "RUN #{s.path}" }
      end

    end
  end
end
