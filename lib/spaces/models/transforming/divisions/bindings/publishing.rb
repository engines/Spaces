module Divisions
  class Binding < ::Divisions::TargetingSubdivision
    module Publishing

      def localized
        empty.tap do |m|
          m.struct = struct.without(:target).tap do |s|
            s.identifier ||= target_identifier
            s.target_identifier = target_identifier
          end.compact
        end
      end

      def globalized
        if l = location
          empty.tap do |m|
            m.struct = struct.without([:identifier, :target_identifier]).tap do |s|
              s.target = l.struct
              s.identifier = identifier unless identifier == l.identifier
            end
          end
        end
      end

      def location
        if locations.exist?(target_identifier)
          locations.by(target_identifier)
        end
      end

    end
  end
end
