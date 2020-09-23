module Packing
  module PostProcessors
    class PostProcessors < ::Emissions::Divisible

      class << self
        def inheritance_paths; __dir__ ;end
      end

      require_files_in :stanzas

      def emit
        stanzas.map(&:to_h)
      end

    end
  end
end
