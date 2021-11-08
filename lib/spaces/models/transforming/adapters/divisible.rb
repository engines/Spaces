require_relative 'division'

module Adapters
  class Divisible < Division

    class << self
      def subadapter_class
        Module.const_get(name.singularize)
      end
    end

    delegate(
      subadapter_class: :klass,
      [:any?, :empty?, :map, :each, :count, :[], :first] => :all
    )

    def all
      @all ||= division.all.map { |s| subadapter_for(s) }&.compact || []
    end

    def subadapter_for(subdivision)
      subadapter_class.new(subdivision)
    end

    def snippets
      all.map(&:snippets).flatten.compact
    end

  end
end
