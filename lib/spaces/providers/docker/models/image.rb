require_relative 'model'

module Providers
  module Docker
    class Image < Model

      relation_accessor :history

      delegate(remove: :model_interface)

      def summary
        @summary ||= super.merge(
          tags: tags,
          size: size
        )
      end

      def resolution_identifier
        tags.first.split(':').first.as_compound('_') if tags.first
      end

      def identifier = id[7..18]
      def tags = repo_tags

      def delete
        remove
      end

      def tagged? = !tags.first.include?('none')

      def layer_ids = history.select { |h| h.id != '<missing>' && h.tags }.map(&:id)

      def all_others = all.reject { |i| i.id == id }

      def descendants
        @descendants ||=
          all_others.select { |i| i.layer_ids.include?(id) }.reverse
      end

      def initialize(interface, image_interface)
        super
        self.history = image_interface.history.to_struct
      end

    end
  end
end
