module Divisions
  class Permission < ::Divisions::Subdivision

    class << self
      def features = [:file, :mode, :ownership]
    end

    def recursion = ('-R' if struct.recursion)

  end
end
