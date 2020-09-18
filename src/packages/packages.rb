require_relative '../releases/divisible'
require_relative 'package'

module Packages
  class Packages < ::Releases::Divisible

    class << self
      def script_lot ;end
      def inheritance_paths; __dir__ ;end
    end

  end
end
