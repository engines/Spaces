require_relative '../provider'

module Provisioning
  module Providers
    module Lxd
      class Lxd < Provider

        class << self
          def inheritance_paths; [__dir__, super] ;end
        end

        require_files_in :stanzas

      end
    end
  end
end
