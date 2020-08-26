require_relative '../../releases/subdivision'

module Provisioning
  module Containers
    class Container < ::Releases::Subdivision

      class << self
        def qualifier
          name.split('::').last.downcase
        end

        def inheritance_paths; __dir__ ;end
      end

      require_files_in :stanzas

    end
  end
end
