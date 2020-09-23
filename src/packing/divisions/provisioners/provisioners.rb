module Packing
  module Provisioners
    class Provisioners < ::Emissions::Divisible

      class << self
        def inheritance_paths; __dir__ ;end
      end

      require_files_in :stanzas

      def emit
        stanzas.map(&:to_h).flatten.compact
      end

    end
  end
end
