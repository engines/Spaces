require_relative '../nodule'

module Nodules
  module Apache
    class Apache < Nodule

      class << self
        def inheritance_paths; __dir__ ;end
      end

      require_files_in :scripts

    end
  end
end
