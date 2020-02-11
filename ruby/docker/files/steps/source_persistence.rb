require_relative 'requires'

module Docker
  module Files
    module Steps
      class SourcePersistence < Step

        def content
          %Q(
          USER 0
          RUN \
            /scripts/prepare_persitent_source.sh
          )
        end

      end
    end
  end
end
