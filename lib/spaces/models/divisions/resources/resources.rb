module Divisions
  class Resources < ::Divisions::Divisible

    def for_type(type) = select { |r| r.type.to_sym == type.to_sym }

  end
end
