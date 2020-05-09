require_relative '../spaces/schema'
require_relative '../bindings/bindings'
require_relative '../bindings/anchor'
require_relative '../docker/files/file'
require_relative '../images/subject'
require_relative '../users/user'
require_relative '../domains/domain'

module Installations
  class Schema < ::Spaces::Schema

    class << self
      def associative_classes
        [
          Users::User,
          Domains::Domain
        ]
      end

      def component_classes
        [
          Docker::Files::File,
          Images::Subject
        ]
      end

      def collaborating_classes
        [
          Bindings::Bindings,
          Bindings::Anchor
        ]
      end

      def naming_map
        {
          anchor: :binding_anchor,
          file: :docker_file,
          subject: :image_subject
        }
      end

      def associative_divisions; @associative_divisions ||= map_for(associative_classes) ;end
      def component_class_map; @component_class_map ||= map_for(component_classes) ;end
      def collaborating_classes_map; component_class_map.merge(associative_divisions).merge(super) ;end
    end

    delegate([:associative_divisions, :component_class_map] => :klass)

  end
end
