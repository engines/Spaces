module Divisions
  class Ports < ::Divisions::Divisible

    def commands = all.map(&:command).join("\n")

    def struct_merged_with(other) = empty? ? other.struct : struct

    def empty? = struct == [] #HACKY!

  end
end
