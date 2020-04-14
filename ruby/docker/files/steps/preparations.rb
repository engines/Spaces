require_relative 'requires'

module Docker
  module Files
    module Steps
      class Preparations < Step

        def product
          %Q(
         USER 0
          RUN \
            ln -s /usr/local/ /home/local && \
            chown -R $ContUser /usr/local/ 
          )
        end

      end
    end
  end
end
