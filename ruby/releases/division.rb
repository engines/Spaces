require_relative 'component'

module Releases
  class Division < Component

    class << self
      def prototype(collaboration:, label:)
        new(collaboration: collaboration, label: label)
      end
    end

    attr_accessor :label

    def related_divisions
      @related_divisions ||= collaboration.divisions
    end

    def scripts
      [super, all&.map(&:scripts)].flatten.compact.uniq(&:uniqueness)
    end

    def all
      @all ||= struct&.map { |s| subdivision_for(s) }
    end

    def subdivision_for(struct)
      subdivision_class.new(struct: struct, division: self)
    rescue NameError
      struct
    end

    def subdivision_class; Module.const_get(klass.name.singularize) ;end
    def release_path; "#{super}/#{label}" ;end

    def memento; all&.map(&:memento) || super ;end

    def initialize(struct: nil, collaboration: nil, label: nil)
      self.collaboration = collaboration
      self.label = label
      self.struct = struct || collaboration&.struct[label] || default
    end

    def default ;end

  end
end
