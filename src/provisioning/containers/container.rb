require_relative '../../releases/subdivision'

module Provisioning
  module Containers
    class Container < ::Releases::Subdivision

      class << self
        def inheritance_paths; __dir__ ;end
      end

      delegate(identifier: :release)

      require_files_in :stanzas

    end
  end
end
