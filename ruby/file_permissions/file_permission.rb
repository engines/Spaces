require_relative '../collaborators/subdivision'

module FilePermissions
  class FilePermission < ::Collaborators::Subdivision

    def recursive?
      struct.recursive
    end

  end
end
