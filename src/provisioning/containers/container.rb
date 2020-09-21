require_relative '../../emitting/emissions/subdivision'

module Provisioning
  module Containers
    class Container < ::Emitting::Subdivision

      class << self
        def inheritance_paths; __dir__ ;end
      end

      delegate(identifier: :emission)

      require_files_in :stanzas

    end
  end
end
