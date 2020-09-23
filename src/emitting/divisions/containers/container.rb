require_relative '../../emissions/subdivision'

module Provisioning
  module Containers
    class Container < ::Emissions::Subdivision

      class << self
        def inheritance_paths; __dir__ ;end
      end

      delegate(identifier: :emission)

      require_files_in :stanzas

    end
  end
end
