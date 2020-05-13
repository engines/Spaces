require_relative 'collaborator'

module Releases
  class Division < Collaborator

    def scripts
      [super, all&.map(&:scripts)].flatten.compact.uniq(&:uniqueness)
    end

    def all
      @all ||= struct.map { |s| subdivision_for(s) }
    end

    def subdivision_for(struct)
      subdivision_class.new(struct: struct, division: self)
    rescue NameError
      struct
    end

    def subdivision_class; Module.const_get(klass.name.singularize) ;end
    def installation_path; "#{super}/#{label}" ;end

    def memento; all&.map(&:memento) || super ;end

  end
end
