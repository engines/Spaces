require_relative 'requires'

module Docker
  module Files
    module Steps
      class SourcePersistence < Step

        def product
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
