require_relative '../docker/files/file'
require_relative '../images/subject'
require_relative '../users/user'
require_relative '../domains/domain'
require_relative '../blueprints/schema'

module Installations
  module Schema
    include ::Blueprints::Schema

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
  end
end
