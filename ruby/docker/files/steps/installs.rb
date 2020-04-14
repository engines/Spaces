require_relative 'requires'

module Docker
  module Files
    module Steps
      class Installs < Step

        def product
          if File.exist?()
          end
          %Q(
          WORKDIR /home/
          RUN \
            bash /home/setup.sh
          )
        end

      end
    end
  end
end
