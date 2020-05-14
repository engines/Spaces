require_relative '../../releases/division'

module Docker
  module Files
    class NativeSegment < ::Releases::Division

      class << self
        def step_precedence
          { early: [:native] }
        end
      end

      def identifier; struct.identifier || super ;end

    end
  end
end
