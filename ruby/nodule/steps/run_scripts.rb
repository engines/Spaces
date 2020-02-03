require_relative '../../docker/file/step'

module Nodule
  class Nodules < ::Spaces::Model
    class RunScripts < Docker::File::Step

      def content
        context.scripts.map { |a| "RUN /#{context.path}/#{a.type}/#{a.name}.sh" }
      end

    end
  end
end
