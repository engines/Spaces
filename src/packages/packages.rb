require_relative '../releases/division'
require_relative 'package'

module Packages
  class Packages < ::Releases::Division

    class << self
      def script_lot ;end
      def inheritance_paths; __dir__ ;end
    end

  end
end
