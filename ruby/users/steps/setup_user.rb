require_relative '../../docker/files/step'

module Users
  module Steps
    class SetupUser < Docker::Files::Step
      def product
        "RUN /#{context.product_path}/setup_user.sh"
      end

    end
  end
end
