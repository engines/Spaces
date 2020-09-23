require_relative '../provider'

module Providers
  module LXD
    class LXD < Provider

      class << self
        def inheritance_paths; [__dir__, super] ;end
      end

      require_files_in :stanzas

    end
  end
end
