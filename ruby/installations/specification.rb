require_relative '../docker/files/file'
require_relative '../images/subject'
require_relative '../users/user'
require_relative '../projects/specification'

module Installations
  module Specification
    include ::Projects::Specification

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

    def division_map
      super.merge({
        file: :docker_file,
        subject: :image_subject
      })
    end

    def mutable_divisions
      super + [:user]
    end
  end
end
