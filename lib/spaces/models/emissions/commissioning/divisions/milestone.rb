module Divisions
  class Milestone < ::Divisions::Subdivision

    def path; struct.path ;end

    def command_line
      "#{path}"
    end

  end
end
