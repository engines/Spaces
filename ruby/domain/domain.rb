require_relative '../spaces/model'
require_relative '../container/docker_file_layering'

module Domain
  class Domain < ::Spaces::Model
    include Container::DockerFileLayering

    attr_reader *precedence

    def variables
      %Q(
        ENV Hostname '#{struct.identifier}'
        ENV Domainname 'current.spaces.org'
        ENV fqdn '#{struct.identifier}.current.spaces.org'
      )
    end

  end
end
