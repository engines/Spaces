require_relative 'requires'

module Docker
  class File < ::Spaces::Product
    class SourceProtection < Step

      def content
        %Q(
        USER 0
        RUN \
        /scripts/chown_app_dir.sh
        )
      end

    end
  end
end
