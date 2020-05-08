require_relative '../../docker/files/step'

module Images
  module Steps
    class Injections < Docker::Files::Step
      def instructions
        "RUN /#{context.installation_path}/injections.sh"
      end

    end
  end
end
