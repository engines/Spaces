require_relative '../../emissions/subdivision'

module Packages
  class Package < ::Emissions::Subdivision

    class << self
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :scripts

  end
end
