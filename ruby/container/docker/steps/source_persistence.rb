require_relative 'requires'

module Container
  module Docker
    class File
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
