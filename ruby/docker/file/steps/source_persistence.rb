require_relative 'requires'

module Docker
  class File < ::Spaces::Product
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
