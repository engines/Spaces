require_relative '../service_network'

module ServiceNetworking
  module Consul
    class Consul < ServiceNetwork

      class << self
        def inheritance_paths; __dir__ ;end
      end

      require_files_in :stanzas

    end
  end
end
