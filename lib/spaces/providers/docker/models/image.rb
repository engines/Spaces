require_relative 'model'

module Providers
  module Docker
    class Image < Model

      relation_accessor :history

      def summary
        @summary ||= OpenStruct.new(
          identifier: identifier,
          tags: tags,
          size: size
        )
      end

      def identifier; id[7..18] ;end
      def tags; repo_tags ;end

      def tagged?
        !tags.first.include?('none')
      end

      def descendants
        @descendants ||=
          all_others.select { |i| i.layer_ids.include?(id) }.reverse
      end

      def layer_ids
        history.select { |h| h.id != '<missing>' && h.tags }.map(&:id)
      end

      def all_others
        all.reject { |i| i.id == id }
      end

      def initialize(interface, image_interface)
        super
        self.history = image_interface.history.to_struct
      end

    end
  end
end
