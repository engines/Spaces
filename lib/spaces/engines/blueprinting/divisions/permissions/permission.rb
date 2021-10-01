module Divisions
  class Permission < ::Divisions::Subdivision
    include ::Packing::Division

    class << self
      def features; [:file, :mode, :ownership] ;end
    end

    def recursion; '-R' if struct.recursion ;end

  end
end
