require_relative '../../docker/files/step'

module Bindings
  module Steps
    class Persistence < Docker::Files::Step

      def product
      %Q(
      'RUN persistent_directories.sh'
      'RUN persistent_files.sh'
      )
      end

    end
  end
end
