require_relative '../installations/subdivision'

module FilePermissions
  class FilePermission < ::Installations::Subdivision

    def recursive?
      struct.recursive
    end

  end
end
