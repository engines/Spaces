require_relative '../installations/subdivision'

module FilePermissions
  class FilePermission < ::Installations::Subdivision

    def recursive?
      struct.recursive
    end

    def subspace_path
      context.subspace_path
    end

  end
end
