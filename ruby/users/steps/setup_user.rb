require_relative '../../docker/files/step'

module Users
  module Steps
    class SetupUser < Docker::Files::Step
      def instructions
        "RUN /#{context.installation_path}/setup_user.sh"
      end

    end
  end
end
