require_relative '../installations/subdivision'

module Replacements
  class Replacement < ::Installations::Subdivision

    class << self
      def inheritance_paths; __dir__; end
    end

    require_files_in :scripts

  end
end
