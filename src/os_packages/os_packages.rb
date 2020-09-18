require_relative '../releases/divisible'

module OsPackages
  class OsPackages < ::Releases::Divisible

    class << self
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :scripts

  end
end
