module Divisions
  class ManagedPackages < ::Divisions::Division

    class << self
      def subdivision_class = ManagedPackageList
    end

    delegate(subdivision_class: :klass)

    alias_method :languages, :keys

    def all
      @all ||= languages.map { |l| subdivision_for(l) }.compact
    end

    def subdivision_for(language) =
      subdivision_class.prototype(type: language, struct: struct[language], division: self)

    def method_missing(m, *args, &block)
      all.detect { |a| a.identifier == m.to_s }
    end

    def respond_to_missing?(m, *)
      keys.include?(m)
    end

  end
end
