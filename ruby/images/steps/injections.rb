require_relative '../../docker/files/step'

module Images
  module Steps
    class Injections < Docker::Files::Step
      def product
        "RUN #{context.build_script_path}/injections.sh"
      end

    end
  end
end
