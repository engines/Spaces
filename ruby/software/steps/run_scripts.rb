require_relative '../../docker/file/step'

class Software < ::Spaces::Model
  class RunScripts < Docker::File::Step

    def content
      context.scripts.flatten.map { |s| "RUN #{s.path}" }
    end

  end
end
