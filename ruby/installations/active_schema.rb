require_relative '../projects/active_schema'
require_relative 'schema'

module Installations
  class ActiveSchema < ::Projects::ActiveSchema
    extend Schema

    class << self
      def product_collaborators
        @@product_collaborators ||= map_for(product_classes)
      end

      def installation_divisions
        @@installation_divisions ||= map_for(installation_classes)
      end

      def all_collaborators
        @@all_installation_collaborators ||= super.merge(installation_divisions).merge(product_collaborators)
      end
    end

    delegate([:product_collaborators, :installation_divisions] => :klass)

    def collaborate_anyway?(key)
      necessary_keys.include?(key)
    end

    def necessary_keys
      product_collaborators.keys + installation_divisions.keys
    end

  end
end
