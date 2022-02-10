module Divisions
  class Milestone < ::Divisions::Subdivision

    def precedence; struct.precedence ;end
    def path; struct.path ;end

  end
end
