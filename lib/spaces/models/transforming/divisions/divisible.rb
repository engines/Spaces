require_relative 'division'

module Divisions
  class Divisible < Division

    class << self
      def subdivision_class = class_for(name.singularize)

      def default_struct = []
    end

    delegate(
      subdivision_class: :klass,
      [:any?, :empty?, :map, :select, :detect, :each, :count, :[], :first] => :all
    )

    alias_method :divisible_embedded_with, :embedded_with

    def related_divisions
      @related_divisions ||= emission.divisions
    end

    def localized = with_all_as(:localized)
    def globalized = with_all_as(:globalized)
    def inflated = with_all_as(:inflated)
    def deflated = with_all_as(:deflated)
    def resolved = with_all_as(:resolved)

    def with_all_as(transformation) =
      empty.tap { |d| d.struct = transformed_to(transformation).map(&:struct) }

    def transformed_to(transformation) =
      all.map { |i| i.send(transformation) }.compact

    def all
      @all ||= struct&.map { |s| subdivision_for(s) }&.compact || []
    end

    def subdivision_for(struct) =
      subdivision_class.new(struct: struct, division: self)

    def struct_merged_with(other) = [struct, other.struct].flatten.uniq
    alias_method :merge, :struct_merged_with

  end
end
