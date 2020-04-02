require 'docker-api'
require_relative '../spaces/space'

module Docker
  class Space < ::Spaces::Space

    delegate([:connection, :version, :info, :default_socket_url] => :bridge)

    def bridge
      Docker
    end

  end
end
