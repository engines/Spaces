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

      def globalized
        if p = publication
          if pb = publishing_binding
            empty.tap do |m|
              m.struct = struct.without([:identifier, :target_identifier]).tap do |s|
                s.target = pb.struct.target
                s.identifier = identifier unless identifier == pb.identifier
              end
            end
          end
        end
      end

      def publication
        if publications.exist?(context_identifier)
          publications.by(context_identifier)
        end
      end


      protected

      def publishing_binding
        publication.bindings.all.detect { |b| b.identifier == identifier }
      end

    end
  end
end
