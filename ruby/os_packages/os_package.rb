require_relative '../installations/subdivision'

module OsPackages
  class OsPackage < ::Installations::Subdivision

    def subspace_path
      "#{super}/#{build_script_path}"
    end

  end
end
