require_relative '../spaces/model'
require_relative '../container/docker/collaboration'

module Framework
  class Framework < ::Spaces::Model
    include Container::Docker::Collaboration

    def variables
      %Q(
        ENV CONTFSVolHome /home/fs/
        ENV FRAMEWORK '#{identifier}'
        ENV RUNTIME '#{identifier}'
        ENV PORT '8000'
      )
    end

    def adds
      %Q(
        ADD scripts /scripts
        ADD home home
        ADD spaces home/spaces
        ADD home/start.sh #{start_script_path}
      )
    end

    def identifier
      self.class.identifier
    end
  end
end
