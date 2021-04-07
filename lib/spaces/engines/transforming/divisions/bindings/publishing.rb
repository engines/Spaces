module Divisions
  class Binding < ::Divisions::TargetingSubdivision
    module Publishing

      def localized
        empty.tap do |m|
          m.struct = struct.without(:target).tap do |s|
            s.identifier ||= target_identifier
            s.target_identifier = target_identifier
          end
        end
      end

    end
  end
end
