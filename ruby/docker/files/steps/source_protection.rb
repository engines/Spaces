require_relative 'requires'

module Docker
  module Files
    module Steps
      class SourceProtection < Step

        def product
          %Q(
          USER 0
          RUN \
          /scripts/chown_app_dir.sh
          )
        end

      end
    end
  end
end
