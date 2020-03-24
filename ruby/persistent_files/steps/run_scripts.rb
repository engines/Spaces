require_relative '../../docker/files/step'

module PersistentFiles
  module Steps
    class RunScripts < Docker::Files::Step

      def product
        'RUN persistent_files.sh'
      end

    end
  end
end
