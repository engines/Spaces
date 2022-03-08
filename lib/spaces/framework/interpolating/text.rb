module Interpolating
  class Text < ::Spaces::Model

    class << self
      def infix_class; Infix ;end

      def interpolation_marker; '^^' ;end
    end

    relation_accessor :transformable

    attr_accessor :origin

    delegate(
      [:infix_class, :text_class, :interpolation_marker] => :klass,
      context_identifier: :transformable
    )

    def resolved; @resolved ||= contains_interpolation? ? with_resolved_infixes : origin ;end

    alias_method :content, :resolved

    def with_resolved_infixes; immutables.zip(infixes_resolved).flatten.join ;end
    def infixes_resolved; infixes.map(&:resolved) ;end

    def contains_interpolation?
      origin.include?(interpolation_marker)
    rescue NoMethodError
      false
    end

    def complete?
      !resolved.to_s.include?(interpolation_marker)
    end

    def immutables; splits(:even?) ;end
    def infixes; splits(:odd?).map { |s| infix_for(s) } ;end

    def splits(method); origin.split(interpolation_marker).select.with_index { |_, i| i.send(method) } ;end

    def infix_for(string)
      infix_class.new(original_value: string, text: self)
    end

    def to_s; origin ;end

    def initialize(origin:, transformable:)
      self.transformable = transformable
      self.origin = origin
    end

  end
end
