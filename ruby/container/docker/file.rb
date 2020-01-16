require_relative '../tensor'
require_relative '../package'
require_relative 'layering'

module Container
  module Docker
    class File < ::Spaces::Product
      include Layering

      class << self
        def collaborator_precedence
          @@collaborator_precedence ||= {
            final:
              [:needs, :docker_file, :environment, :domain, :framework],
            default:
              [:framework, :needs, :docker_file, :environment, :domain]
          }
        end

        def step_precedence
          @@docker_file_step_precedence ||= [:preparations, :packages, :permissions, :templates, :source_protection, :replacements, :seeds, :tasks, :data_persistence, :installs, :source_persistence]
        end
      end

      attr_reader *precedence
      attr_reader *step_precedence

      relation_accessor :tensor,
        :dependencies

      def dependencies
        @dependencies ||= tensor.dependencies&.map do |d|
          d.docker_file
        end.compact || []
      end

      def collaborator_precedence
        self.class.collaborator_precedence
      end

      def step_precedence
        self.class.step_precedence
      end

      def step_precedence
        @step_precedence ||= [:preparations, :packages, :permissions, :templates, :source_protection, :replacements, :seeds, :tasks, :data_persistence, :installs, :source_persistence]
      end

      def content
        layers.flatten.compact.join("\n")
      end

      def layers
        precedence.map do |p|
          best_collaborator_precedence_for(p).map { |c| tensor.send(c) }.flatten.compact.map { |r| r.send(p) }
        end
      end

      def best_collaborator_precedence_for(precedence)
        (collaborator_precedence[precedence] || collaborator_precedence[:default])
      end

      def variables
        %Q(
          ENV Memory '#{tensor.struct.software.memory_usage.recommended}'

          ENV cont_uid '100124'
          ENV data_gid '1111'
          ENV data_uid '1111'
        )
      end

      def volumes
        %Q(
          VOLUME /var/log/
          VOLUME /home/fs/
          VOLUME /home/fs_src/
        )
      end

      def adds
        %Q(
          ADD scripts /scripts
          ADD home home
          ADD spaces home/spaces
          ADD home/start.sh #{start_script_path}
          USER 0
          RUN \
            mkdir -p /home/fs/local/
        )
      end

      def preparations
        [copy_sudo_list, repositories]
      end

      def copy_sudo_list
        "COPY sudo_list /etc/sudoers.d/container"
      end

      def repositories
        %Q(
          USER 0
          RUN \
            /scripts/set_cont_user.sh && \
            ln -s /usr/local/ /home/local && \
            chown -R $ContUser /usr/local/ && \
            add-apt-repository  -y ppa:opencpn/opencpn && \
            apt-get -y update && \
        )
      end

      def packages
        [
          %Q(
            apt-get install -y mysql-client make && \
          ), # TODO: how do we generalise this? with a dependency!

          package_class.new(tensor.descriptor).installation
        ]
      end

      def permissions
        %Q(
          /scripts/recursive_write_permissions.sh test_package_dest/test_write_rec_dir && \
          /scripts/write_permissions.sh test_package_dest/test_write_file test_package_dest/test_write_dir test_package_dest/test_write_rec_dir && \
        )
      end

      def templates
         '/scripts/install_templates.sh'
      end

      def source_protection
        %Q(
          USER 0
          RUN \
          /scripts/chown_app_dir.sh
        )
      end

      def replacements
        tensor.struct.adaptations&.replacements&.map do |r|
          %Q(
            RUN cat #{r.source} | sed #{r.string} > #{tmp}
            RUN cp #{tmp} #{r.destination}
          )
        end
      end

      def seeds
        %Q(
          RUN \
            cat /home/app//sql/create_tables.sql | sed "/TBLE/s//TABLE/" > /tmp/create_tables.sql.0&& \
            cp /tmp/create_tables.sql.0 /home/app//sql/create_tables.sql&& \
        ) # TODO: more to do here
      end

      def data_persistence
        %Q(
          /scripts/persistent_dirs.sh enginetest:/home/app/fresh_dir_perm_test enginetest:/home/app/home_persistent enginetest:/usr/local/local_persist enginetest:/home/home_dir/home_dir_persist enginetest:/home/app/test_package_dest/test_persist_dir data:/home/app/persistent && \
          /scripts/persistent_files.sh enginetest:app/fresh_test_persistent_file data:app/test_package_dest/test_persist_file
        )
      end

      def installs
        %Q(
          WORKDIR /home/
          RUN \
            bash /home/setup.sh
        )
      end

      def source_persistence
        %Q(
          USER 0
          RUN \
            /scripts/prepare_persitent_source.sh
        )
      end

      def final
        %Q(
          RUN \
            /scripts/set_data_permissions.sh && \
            /scripts/_finalise_environment.sh && \
            /home/spaces/scripts/build/post_build_clean.sh
          ENV buildtime_only '.'
          USER $ContUser
          CMD ["#{start_script_path}"]
        )
      end

      def start_script_path
        '/home/spaces/scripts/startup/start.sh'
      end

      def file_path
        "#{identifier}/DockerFile"
      end

      def identifier
        tensor.struct.software.title
      end

      def descriptor
       tensor.descriptor
      end

      def package_class
        Package
      end

      def initialize(tensor)
        self.tensor = tensor
      end

    end
  end
end
