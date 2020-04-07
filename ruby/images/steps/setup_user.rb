require_relative '../../docker/files/step'


module Images
  module Steps
    class SetupUser < Docker::Files::Step
      def product
        "RUN   #{context.build_script_path}/setup_user.sh"
      end

    end
  end
end
