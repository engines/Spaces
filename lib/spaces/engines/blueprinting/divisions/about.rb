module Divisions
  class About < ::Divisions::Division

    class << self
      def features; [:title, :explanation] ;end
    end

  end
end
