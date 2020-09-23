module Nodules
  module R
    class R < Nodule

      class << self
        def inheritance_paths; __dir__ ;end
      end

      require_files_in :scripts

    end
  end
end
