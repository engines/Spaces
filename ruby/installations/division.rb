require_relative 'collaborator'

module Installations
  class Division < Collaborator

    def all
      @all ||= struct.map { |s| subdivision_for(s) }
    end

    def subdivision_for(struct)
      subdivision_class.new(struct: struct, context: self)
    end

    def scripts
      [super, all&.map(&:scripts)].flatten.compact.uniq(&:uniqueness)
    end

  end
end
