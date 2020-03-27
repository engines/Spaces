require_relative '../installations/subdivision'

module OsPackages
  class OsPackage < ::Installations::Subdivision

    def subspace_path
      "#{context.subspace_path}/#{build_script_path}"
    end

    def build_script_path
      context.build_script_path
    end

  end
end
