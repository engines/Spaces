require_relative '../provider'

module Provisioning
  module Providers
    module Docker
      class Docker < Provider

        class << self
          def inheritance_paths; [__dir__, super] ;end
        end

        require_files_in :stanzas

      end
    end
  end
end
