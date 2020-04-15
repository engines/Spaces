require_relative '../docker/files/file'
require_relative '../images/subject'
require_relative '../users/user'

module Installations
  module Specification

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
      @@division_map ||= {
        file: :docker_file,
        subject: :image_subject
      }
    end

    def mutable_divisions
      [:user]
    end
  end
end
