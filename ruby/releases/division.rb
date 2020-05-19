require_relative 'component'

module Releases
  class Division < Component

    class << self
      def prototype(stage:, label:)
        new(stage: stage, label: label)
      end
    end

    attr_accessor :label

    def related_divisions
      @related_divisions ||= stage.divisions
    end

    def scripts
      [super, all&.map(&:scripts)].flatten.compact.uniq(&:uniqueness)
    end

    def all
      @all ||= struct&.map { |s| subdivision_for(s) }
    end

    def subdivision_for(struct)
      subdivision_class.new(struct: struct, division: self)
    rescue NameError => e
      warn(error: e, struct: struct)
      struct
    end

    def subdivision_class; Module.const_get(klass.name.singularize) ;end
    def release_path; "#{super}/#{label}" ;end

    def memento; all&.map(&:memento) || super ;end

    def initialize(struct: nil, stage: nil, label: nil)
      self.stage = stage
      self.label = label
      self.struct = struct || stage&.struct[label] || default
    end

    def default ;end

  end
end
