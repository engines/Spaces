require_relative 'tensor'
require_relative 'docker_file_layering'

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

    def work_directories
      'WORKDIR /home/app'
    end

    def scripts
      [archive_layer, chown_layer]
    end

    def archive_layer
      %Q(
        USER 0
        RUN \
          /scripts/set_cont_user.sh && \
          echo "#App Archives" && \
          /scripts/package_installer.sh  'git'  '#{tensor.struct.descriptor.value}'  '#{tensor.struct.descriptor.identifier}' 'false'  '/home/app'  '#{tensor.struct.descriptor.identifier}/hello'  '' && \
      )
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

    def initialize(tensor)
      self.tensor = tensor
    end

  end
end
