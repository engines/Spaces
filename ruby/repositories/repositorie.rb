require_relative '../installations/subdivision'

module Repositories
  class Repositorie < ::Installations::Subdivision

    def subspace_path
      "#{super}/#{build_script_path}"
    end

  end
end
