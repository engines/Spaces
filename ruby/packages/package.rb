require_relative '../installations/subdivision'

module Packages
  class Package < ::Installations::Subdivision

    class << self
      def inheritance_paths; __dir__; end
    end

    require_files_in :scripts

  end
end
