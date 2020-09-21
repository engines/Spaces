require_relative '../../emitting/emissions/subdivision'

module Provisioning
  module Providers
    class Provider < ::Emitting::Subdivision

      class << self
        def identifier; qualifier ;end

        def inheritance_paths; __dir__ ;end
      end

      require_files_in :stanzas

    end
  end
end
