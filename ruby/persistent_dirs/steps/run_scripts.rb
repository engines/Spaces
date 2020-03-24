require_relative '../../docker/files/step'

module PersistentDirs
  module Steps
    class RunScripts < Docker::Files::Step

      def product
        'RUN persistent_dirs.sh'
      end

    end
  end
end
