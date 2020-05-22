require_relative '../../docker/files/step'

module Users
  module Steps
    class Run < Docker::Files::Step
      def instructions
        "RUN /#{context.release_path}/setup.sh"
      end

    end
  end
end
