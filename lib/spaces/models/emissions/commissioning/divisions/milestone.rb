module Divisions
  class Milestone < ::Divisions::Subdivision

    def precedence = struct.precedence
    def path = struct.path

  end
end
