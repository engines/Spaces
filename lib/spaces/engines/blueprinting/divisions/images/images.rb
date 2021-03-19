module Divisions
  class Images < ::Divisions::Divisible

    def all_as(transformation)
      empty.tap do |d|
        d.struct = all.select { |s| s.type == runtime_type }.map { |i| i.send(transformation).struct }
      end
    end

  end
end
