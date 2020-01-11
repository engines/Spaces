require_relative 'tensor'
require_relative 'docker_file_layering'

module Container
  class DockerFile < ::Spaces::Product
    include DockerFileLayering

    # A mechanism by which software can be made executable.

    class << self
      def collaborator_precedence
        @collaborator_precedence ||= {
          final:
            [:itself, :environment, :domain, :framework],
          default:
            [:framework, :itself, :environment, :domain]
        }
      end
    end

    attr_reader *precedence

    relation_accessor :tensor,
      :dependencies,
      :framework

    def dependencies
      @dependencies ||= tensor.dependencies&.map do |d|
        d.docker_file
      end.compact || []
    end

    def collaborator_precedence
      self.class.collaborator_precedence
    end

    def contents
      layers.flatten.compact.join("\n")
    end

    def layers
      precedence.map do |p|
        (collaborator_precedence[p] || collaborator_precedence[:default]).map do |c|
          self.send(c)&.send(p)
        end
      end
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

    def framework
      if (f = tensor.struct.software.framework)
        @framework ||=
          universe.frameworks.by(f).tap do |m|
            m.struct = duplicate(f)
          end
      end
    end

    def environment
      @environment ||= universe.environments.by('')
    end

    def domain
      #@domain ||= universe.domains.by('')
      @domain ||= universe.domains.model_class.new(tensor.struct.descriptor)
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
