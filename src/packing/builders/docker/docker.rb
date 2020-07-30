require_relative '../builder'

module Packing
  module Builders
    module Docker
      class Docker < Builder

        class << self
          def safety_overrides; { privileged: false } ;end
        end

        alias_method :super_memento, :memento

        def export
          super_memento.tap { |m| m[:export_path] = "#{identifier}.tar" }
        end

        def memento
          super.tap { |m| m[:commit] = true }
        end

      end
    end
  end
end
