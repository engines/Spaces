require_relative 'collaborator'

module Installations
  class Division < Collaborator

    def scripts
      [super, all&.map(&:scripts)].flatten.compact.uniq(&:uniqueness)
    end

    def all
      @all ||= struct.map { |s| subdivision_for(s) }
    end

    def subdivision_for(struct)
      subdivision_class.new(struct: struct, context: self)
    end

    def subdivision_class
      Module.const_get(klass.name.singularize)
    end

    def product_path
       "#{super}/#{blueprint_label}"
    end

  end
end
