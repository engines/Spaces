module Transforming
  class Transformable < ::Spaces::Model

    def complete?; true ;end

    def identifier; struct[:identifier] ;end

    def blueprint_identifier; identifier.split('::').last ;end

    def descriptor_class; ::Spaces::Descriptor ;end

    def arena_stanzas; ;end
    def resolution_stanzas_for(_); ;end

    def random(length); SecureRandom.hex(length.to_i) ;end

    protected

    def all_complete?(array)
      array.map(&:complete?).all_true?
    end

  end
end
