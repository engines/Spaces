require_relative '../installations/subdivision'

module Respository
  class Respository < ::Installations::Subdivision

    def subspace_path
      "#{super}/#{build_script_path}"
    end

  end
end
