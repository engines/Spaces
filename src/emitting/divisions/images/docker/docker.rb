require_relative '../image'

module Packing
  module Images
    module Docker
      class Docker < Image

        class << self
          def safety_overrides; { privileged: false } ;end
        end

        def export
          emit.tap { |m| m[:export_path] = "#{identifier}.tar" }
        end

        def commit
          emit.tap { |m| m[:commit] = true }
        end

      end
    end
  end
end
