require_relative '../spaces/schema'
require_relative 'schema'

module Installations
  class ActiveSchema < ::Spaces::Schema
    extend Schema

    class << self
      def product_collaborators
        @product_collaborators ||= map_for(product_classes)
      end

      def installation_divisions
        @installation_divisions ||= map_for(installation_classes)
      end

      def collaborator_map
        @all_installation_collaborators ||= super.merge(installation_divisions).merge(product_collaborators)
      end
    end

    delegate([:product_collaborators, :installation_divisions, :mutable_divisions] => :klass)

  end
end
