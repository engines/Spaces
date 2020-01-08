require_relative 'framework'

module Framework
  class Rails5 < Framework
    class << self
      def identifier
        'rails5'
      end
    end

    def first_layer(descriptor)
      "FROM engines/ngpassenger:#{descriptor.branch}"
    end

    def setup_layers
      %Q(
        ENV CONTFSVolHome /home/fs/
        ENV WWW_DIR public
        ENV ContUser ruby
        ENV RAILS_ENV production

        ENV SECRET_KEY_BASE	_Engines_System(random(128))
        ENV RAILS_MASTER_KEY _Engines_System(random(32))
        ENV PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

        ADD scripts /scripts
        ADD home home
        ADD engines home/engines

        RUN apt-get update &&\
        	chown $ContUser /opt &&\
        	mkdir -p /home/home_dir/.bundle/ &&\
        	chown -R $ContUser /home/home_dir/.gem/ /home/home_dir/.bundle/ &&\
        	gem install bundle bundler &&\
        	gem update --system
      )
    end

    def stack_layers
      %Q(
        ENV FRAMEWORK '#{identifier}'
        ENV RUNTIME '#{identifier}'
        ENV PORT '8000'
      )
    end

    def mid_layers
      %Q(
        WORKDIR /home/app

        USER 0

        ENV DATABASE_URL $rails_flavor://$dbuser:$dbpasswd@$dbhost/$dbname

        RUN /scripts/configure_nginx.sh &&\
        	/scripts/create_database_yml.sh

        USER $ContUser

        RUN bash /home/setup.sh &&\
          /scripts/run_bundler.sh
      )
    end

    def startup_layer
      "ADD home/start.sh #{start_script_path}"
    end

    def start_layers
      %Q(
        ENV ContUser www-data

        WORKDIR /home/app

        VOLUME /var/log/

        RUN ln -s /home/app /var/www &&\
            usermod -G data-user -a www-data &&\
            mkdir -p /home/app/tmp &&\
            chmod u+w /home/app/tmp
      )
    end
  end
end
