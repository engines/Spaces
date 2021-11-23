module Transforming
  class Transformable < ::Spaces::Model

    def complete?; true ;end

    def identifier; struct[:identifier] ;end

    def blueprint_identifier; identifier.low ;end

    def identifier_separator; ''.with_identifier_separator; end

    def random(length); SecureRandom.hex(length.to_i) ;end

    protected

    def all_complete?(array)
      array.map(&:complete?).all_true?
    end

  end
end
