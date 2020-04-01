require_relative '../../docker/files/step'

module Bindings
  module Steps
    class Persistence < Docker::Files::Step

      def product
      %Q(
      RUN persistence.sh
      )
      end

    end
  end
end
