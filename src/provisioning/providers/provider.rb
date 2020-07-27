require_relative '../../releases/subdivision'

module Provisioning
  module Providers
    class Provider < ::Releases::Subdivision

      class << self
        def identifier; qualifier ;end

        def inheritance_paths; __dir__ ;end
      end

      require_files_in :stanzas

    end
  end
end
