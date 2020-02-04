require_relative '../../docker/file/step'

module Nodule
  class Nodules < ::Spaces::Model
    class RunScripts < Docker::File::Step

      def content
        context.scripts.map { |s| "RUN #{s.file_path" }
      end

    end
  end
end
