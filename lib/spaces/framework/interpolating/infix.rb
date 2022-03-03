require_relative 'resolving'
require_relative 'iterating'

module Interpolating
  class Infix < ::Spaces::Model
    include Resolving
    include Iterating

    attr_accessor :original_value
    attr_accessor :last_iteration
    relation_accessor :text

    delegate(
      [:transformable, :interpolation_marker] => :text,
      emission: :transformable
    )

    def resolved
      resolvable? ? completed : "#{interpolation_marker}#{original_value}#{interpolation_marker}"
    end

    def object_in_expression; acceptable_expression.first ;end
    def method_in_expression; acceptable_expression.last.split(/[()]+/) ;end

    def acceptable_expression
      @acceptable_expression ||= ([:unqualified] + working_value.split('.')).last(2)
    end

    def working_value
      last_iteration || original_value
    end

    def initialize(original_value:, text:, last_iteration: nil)
      self.original_value = original_value
      self.last_iteration = last_iteration
      self.text = text
    end

    def to_s; resolved ;end

  end

  module Errors
    class Unresolvable < ::Spaces::Errors::SpacesError
    end
  end
end
