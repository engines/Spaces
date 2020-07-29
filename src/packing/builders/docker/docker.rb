require_relative '../builder'

module Packing
  module Builders
    module Docker
      class Docker < Builder

        def export
          memento.tap { |m| m[:export_path] = "#{identifier}.tar" }
        end

        def commit
          memento.tap { |m| m[:commit] = true }
        end

      end
    end
  end
end
