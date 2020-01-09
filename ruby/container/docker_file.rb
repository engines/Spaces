require_relative 'tensor'

module Container
  class DockerFile < ::Spaces::Product
    # A mechanism by which software can be made executable.

    relation_accessor :tensor,
      :framework

    def initialize(tensor)
      self.tensor = tensor
    end

    def contents
      layers.flatten.compact.join("\n\n")
    end

    def layers
      [
        framework.first_layer(descriptor),
        framework.setup_layers,
        memory_layer,
        environment.locale_layers,
        domain.layers(tensor.struct.version.software),
        framework.stack_layers,
        user_layers,
        root_layer,
        archive_layer,
        chown_layer,
        framework.mid_layers,
        work_layers,
        framework.startup_layer,
        clearing_layer,
        framework.start_layers
      ]
    end

    def memory_layer
      "ENV Memory '#{tensor.struct.version.software.memory_usage.recommended}'"
    end

    def user_layers
      %Q(
        ENV cont_uid '100124'
        ENV data_gid '1111'
        ENV data_uid '1111'
      )
    end

    def root_layer
      'USER 0'
    end

    def archive_layer
      %Q(
        RUN \
          /scripts/set_cont_user.sh && \
          echo "#App Archives" && \
          /scripts/package_installer.sh  'git'  '#{tensor.struct.version.url}'  '#{tensor.struct.version.descriptor.name}' 'false'  '/home/app'  '#{tensor.struct.version.descriptor.name}/hello'  '' && \
      )
    end

    def chown_layer
      %Q(
        RUN \
          /scripts/chown_app_dir.sh
      )
    end

    def work_layers
      %Q(
        WORKDIR /home/app
        VOLUME /var/log/
      )
    end

    def clearing_layer
      'RUN /home/spaces/scripts/build/post_build_clean.sh'
    end

    def framework
      @framework ||= universe.frameworks.by(tensor.struct.version.software.framework).tap do |m|
        m.struct = duplicate(tensor.struct.version.software.framework)
      end
    end

    def environment
      @environment ||= universe.environments.by('')
    end

    def domain
      @domain ||= universe.domains.by('')
    end

    def file_path
      "#{name}/DockerFile"
    end

    def name
      tensor.struct.version.descriptor.name
    end

    def universe
      @universal_space ||= Universal::Space.new
    end

  end
end
