require_relative '../emitting/emissions/divisible'

module OsPackages
  class OsPackages < ::Emitting::Divisible

    class << self
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :scripts

  end
end
