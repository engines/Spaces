require_relative '../../../docker/files/step'

module Frameworks
  module Rails5
    module Steps
      class Bundle < Docker::Files::Step

        def instructions
          %Q(
          RUN apt-get update &&\
            chown $ContUser /opt &&\
            mkdir -p /home/home_dir/.bundle/ &&\
            chown -R $ContUser /home/home_dir/.gem/ /home/home_dir/.bundle/ &&\
            gem install bundle bundler &&\
            gem update --system
          )
        end

      end
    end
  end
end
