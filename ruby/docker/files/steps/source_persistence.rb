require_relative '../step'

module Docker
  module Files
    module Steps
      class SourcePersistence < Step

        def instructions
          %Q(
          USER 0
          WORKDIR /
          RUN /build/scripts/persistent_source.sh
          )
        end

      end
    end
  end
end
