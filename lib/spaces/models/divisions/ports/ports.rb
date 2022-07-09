module Divisions
  class Ports < ::Divisions::Divisible

    def commands = all.map(&:command).join("\n")

  end
end
