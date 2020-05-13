require_relative '../releases/subdivision'

module Replacements
  class Replacement < ::Releases::Subdivision

    class << self
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :scripts

  end
end
