require_relative '../../docker/files/step'

module Images
  module Steps
    class Inject < Docker::Files::Step
      def instructions
        "RUN /#{context.release_path}/inject.sh"
      end

    end
  end
end
