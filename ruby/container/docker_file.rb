require_relative 'tensor'
require_relative 'docker_file_layering'
require_relative 'package'

module Container
  class DockerFile < ::Spaces::Product
    include DockerFileLayering

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

    def contents
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
      'VOLUME /var/log/'
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
          echo "#Repositories"&& \
          add-apt-repository  -y ppa:opencpn/opencpn && \
          apt-get -y update && \
      )
    end

    def packages
      [
        %Q(
          echo "#OS Packages" && \
          apt-get install -y mysql-client make && \
        ), # TODO: how do we generalise this?

        package_class.new(tensor.descriptor).installation
      ]
    end

    def chown_layer
      %Q(
        RUN \
          /scripts/chown_app_dir.sh
      )
    end

    def final
      'RUN /home/spaces/scripts/build/post_build_clean.sh'
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
