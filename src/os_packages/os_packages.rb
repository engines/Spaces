require_relative '../releases/division'

module OsPackages
  class OsPackages < ::Releases::Division

    class << self
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :scripts

  end
end
