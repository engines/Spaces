require_relative 'collaboration'

module Releases
  class Stage < Collaboration

    relation_accessor :release

    delegate([:context_identifier, :home_app_path] => :release)

    def identifier
      starter&.identifier || release.stages.find_index(self)
    end

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
    rescue SystemStackError
      super
    end

  end
end
