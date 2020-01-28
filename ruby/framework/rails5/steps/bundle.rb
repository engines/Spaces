require_relative 'requires'

module Framework
  class Rails5
    class Bundle < Docker::File::Step

      def content
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
