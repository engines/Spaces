require_relative '../../docker/files/step'

module Images
  module Steps
    class SourcePersistence < Docker::Files::Step
      def instructions
        %Q(
          USER 0
          WORKDIR /
          RUN #{context.release_path}/persistent_source.sh
          )
      end

    end
  end
end

