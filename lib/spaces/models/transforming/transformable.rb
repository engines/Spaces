module Transforming
  class Transformable < ::Spaces::Model

    def complete? = true

    def identifier = struct[:identifier]

    def identifier_separator = ''.identifier_separator

    def random(length) = SecureRandom.hex(length.to_i)

    protected

    def all_complete?(array) = array.map(&:complete?).all_true?

  end
end
