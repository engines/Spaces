require_relative 'collaboration'

module Releases
  class Stage < Collaboration

    relation_accessor :release

    delegate([:identifier, :home_app_path] => :release)

    def initialize(struct:, release:)
      self.release = release
      self.struct = duplicate(struct)
    end

    def method_missing(m, *args, &block)
      if division_keys.include?(m)
        division_map[m.to_sym] || struct[m]
      else
        release.send(m, *args, &block) || super
      end
    end

  end
end
