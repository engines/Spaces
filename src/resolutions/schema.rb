require_relative '../spaces/schema'
require_relative '../bindings/bindings'
require_relative '../bindings/anchor'
require_relative '../images/subject'
require_relative '../users/user'
require_relative '../domains/domain'

module Resolutions
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
          Images::Subject
        ]
      end

      def division_classes
        [
          Bindings::Bindings,
          Bindings::Anchor
        ]
      end

      def naming_map
        {
          anchor: :binding_anchor,
          subject: :image_subject
        }
      end

      def associative_divisions; @associative_divisions ||= map_for(associative_classes) ;end
      def component_divisions; @component_divisions ||= map_for(component_classes) ;end

      def mandatory_divisions; @mandatory_divisions ||= component_divisions.merge(associative_divisions) ;end
      def mandatory_keys; @mandatory_divisions.keys ;end

      def divisions; mandatory_divisions.merge(super) ;end

    end

    delegate(mandatory_keys: :klass)

  end
end
