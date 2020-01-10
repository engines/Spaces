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

    def volumes
      'VOLUME /home/fs_src/'
    end

    def scripts
      %Q(
        RUN apt-get update &&\
        	chown $ContUser /opt &&\
        	mkdir -p /home/home_dir/.bundle/ &&\
        	chown -R $ContUser /home/home_dir/.gem/ /home/home_dir/.bundle/ &&\
        	gem install bundle bundler &&\
        	gem update --system

        USER 0
        RUN \
          /scripts/set_cont_user.sh && \
          ln -s /usr/local/ /home/local && \
          chown -R $ContUser /usr/local/ && \

          echo "#Write Permissions  Recursive" && \
          /scripts/recursive_write_permissions.sh && \
          echo "#Write Permissions Non Recursive" && \
          /scripts/write_permissions.sh && \
          /scripts/install_templates.sh

        USER $ContUser
        RUN \
          /scripts/persistent_dirs.sh files:/home/app/public && \
          echo "#Persistant Files []"&& \
          /scripts/persistent_files.sh

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

        USER 0
        RUN \
          mkdir -p /home/fs/local/

        USER 0
        RUN \
          /scripts/prepare_persitent_source.sh

        RUN
          /scripts/set_data_permissions.sh&& \
          /scripts/_finalise_environment.sh

        RUN ln -s /home/app /var/www &&\
          usermod -G data-user -a www-data &&\
          mkdir -p /home/app/tmp &&\
          chmod u+w /home/app/tmp
      )
    end
  end
end
