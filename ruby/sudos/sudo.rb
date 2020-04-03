require_relative '../installations/subdivision'

module Sudos
  class Sudo < ::Installations::Subdivision

    def subspace_path
      "#{super}/#{build_script_path}"
    end

  end
end
