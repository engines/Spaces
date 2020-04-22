require_relative '../collaborators/subdivision'

module Packages
  class Package < ::Collaborators::Subdivision

    class << self
      def inheritance_paths; __dir__; end
    end

    require_files_in :scripts

  end
end
