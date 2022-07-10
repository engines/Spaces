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

    def resolved
      @resolved ||= contains_interpolation? ? with_resolved_infixes : origin
    end

    alias_method :content, :resolved

    def with_resolved_infixes = immutables.zip(infixes_resolved).flatten.join
    def infixes_resolved = infixes.map(&:resolved)

    def contains_interpolation?
      origin.include?(interpolation_marker)
    rescue NoMethodError
      false
    end

    def complete? = !resolved.to_s.include?(interpolation_marker)

    def immutables = splits(:even?)
    def infixes = splits(:odd?).map { |s| infix_for(s) }

    def splits(method) =
      origin.split(interpolation_marker).select.with_index { |_, i| i.send(method) }

    def infix_for(string) =
      infix_class.new(original_value: string, text: self)

    def to_s = origin

    def initialize(origin:, transformable:)
      self.transformable = transformable
      self.origin = origin
    end

  end
end
