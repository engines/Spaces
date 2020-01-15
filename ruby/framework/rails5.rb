require_relative 'framework'

module Framework
  class Rails5 < Framework
    class << self
      def identifier
        'rails5'
      end
    end

    def initial
      "FROM spaces/ngpassenger:current"
    end

    def variables
      [
        super,
        %Q(
          ENV WWW_DIR public
          ENV ContUser ruby
          ENV RAILS_ENV production

          ENV SECRET_KEY_BASE	#{SecureRandom.hex(128)}
          ENV RAILS_MASTER_KEY #{SecureRandom.hex(32)}
          ENV PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

          ENV VOLDIR '/home/fs/files'
          ENV volume_name 'files'

          ENV DATABASE_URL $rails_flavor://$dbuser:$dbpasswd@$dbhost/$dbname
        )
      ]
    end

    def tasks
      %Q(
        RUN apt-get update &&\
        	chown $ContUser /opt &&\
        	mkdir -p /home/home_dir/.bundle/ &&\
        	chown -R $ContUser /home/home_dir/.gem/ /home/home_dir/.bundle/ &&\
        	gem install bundle bundler &&\
        	gem update --system

        USER 0
        RUN /scripts/configure_nginx.sh &&\
        	/scripts/create_database_yml.sh

        USER $ContUser
        RUN bash /home/setup.sh &&\
          /scripts/run_bundler.sh

        RUN \
          /scripts/run_rake_task.sh db:migrate&& \
          /scripts/run_rake_task.sh db:seed&& \
          /scripts/run_rake_task.sh assets:precompile
      )
    end
  end
end
