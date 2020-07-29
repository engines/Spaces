require_relative '../../releases/division'

module Packing
  module PostProcessors
    class PostProcessors < ::Releases::Division

      class << self
        def inheritance_paths; __dir__ ;end
      end

      require_files_in :stanzas

      def memento
        stanzas.map(&:to_h)
      end

    end
  end
end
