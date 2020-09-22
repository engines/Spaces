require_relative '../emissions/divisible'

module Divisions
  class OsPackages < ::Emissions::Divisible

    class << self
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :scripts

  end
end
