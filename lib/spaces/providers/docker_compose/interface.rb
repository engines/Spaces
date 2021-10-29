require_relative 'streaming'

module Providers
  module DockerCompose
    class Interface < ::Providers::Interface
      include Streaming

    end
  end
end
