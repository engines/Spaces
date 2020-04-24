require_relative '../docker/files/file'
require_relative '../images/subject'
require_relative '../users/user'
require_relative '../domains/domain'
require_relative '../blueprints/schema'
require_relative '../spaces/schema'

module Installations
  class Schema < ::Blueprints::Schema

    class << self

      def product_classes
        [
          Docker::Files::File,
          Images::Subject
        ]
      end

      def installation_classes
        [
          Users::User,
          Domains::Domain
        ]
      end

      def outline_map
        super.merge({
          file: :docker_file,
          subject: :image_subject
        })
      end

      def mutable_divisions
        [:bindings, :user]
      end

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
