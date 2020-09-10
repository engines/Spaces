require_relative '../nodule'

module Nodules
  module NPM
    class NPM < Nodule

      class << self
        def inheritance_paths; __dir__ ;end
      end

      require_files_in :scripts

    end
  end
end
