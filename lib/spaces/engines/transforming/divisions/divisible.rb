require_relative 'division'

module Divisions
  class Divisible < Division

    class << self
      def subdivision_class
        Module.const_get(name.singularize)
      end

      def default_struct; [] ;end
    end

    delegate(
      subdivision_class: :klass,
      [:any?, :empty?, :map, :each, :count, :[], :first] => :all
    )

    alias_method :divisible_embedded_with, :embedded_with

    def related_divisions
      @related_divisions ||= emission.divisions
    end

    def localized; with_all_as(:localized) ;end
    def globalized; with_all_as(:globalized) ;end
    def inflated; with_all_as(:inflated) ;end
    def deflated; with_all_as(:deflated) ;end
    def resolved; with_all_as(:resolved) ;end

    def with_all_as(transformation)
      empty.tap { |d| d.struct = transformed_to(transformation).map(&:struct) }
    end

    def transformed_to(transformation)
      all.map { |i| i.send(transformation) }.compact
    end

    def all
      @all ||= struct&.map { |s| subdivision_for(s) }&.compact || []
    end

    def subdivision_for(struct)
      subdivision_class.new(struct: struct, division: self)
    end

    def snippets_for(resolution)
      all.map { |d| d.snippets_for(resolution) }.flatten.compact
    end

    def struct_merged_with(other); [struct, other.struct].flatten.uniq ;end
    alias_method :merge, :struct_merged_with

  end
end
