require 'docker-api'
require_relative '../spaces/space'

module Docker
  class Space < ::Spaces::Space
    extend Docker

    delegate(
      [:connection, :version, :info, :default_socket_url] => :klass,
      [:all, :get, :prune] => :bridge
    )

    def create(descriptor)
      bridge.create(name: descriptor.identifier)
    end

    def bridge; {} ;end

  end
end
