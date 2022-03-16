module Providers
  module Docker
    class Image < ::Spaces::Model

      relation_accessor :interface
      relation_accessor :image_interface
      relation_accessor :history

      delegate(all: :interface)

      def state
        @state ||= {
          identifier: identifier,
          tags: tags,
          size: size,
        }
      end

      def identifier; id[7..18] ;end
      def tags; repo_tags ;end

      def layer_ids
        history.select { |h| h.id != '<missing>' && h.tags}.map(&:id)
      end

      def descendant_ids
        descendants.map(&:id)
      end

      def descendants
        @descendants ||=
          all_others.select { |i| i.layer_ids.include?(id) }.reverse
      end

      def all_others
        all.reject { |i| i.id == id }
      end

      def initialize(interface, image_interface)
        self.interface = interface
        self.image_interface = image_interface
        self.struct = image_interface.info.to_struct
        self.history = image_interface.history.to_struct
      end

    end
  end
end
