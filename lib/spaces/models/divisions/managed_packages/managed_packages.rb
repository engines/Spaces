module Divisions
  class ManagedPackages < KeyedDivision

    class << self
      def subdivision_class = ManagedPackageList
    end

    delegate(subdivision_class: :klass)

    alias_method :installer_names, :keys

    def all
      @all ||= installer_names.map { |n| subdivision_for(n) }.compact
    end

    def subdivision_for(installer_name) =
      subdivision_class.new(installer_name: installer_name, struct: struct[installer_name], division: self)

    def method_missing(m, *args, &block)
      return all.detect { |a| a.identifier == m } if keys.include?(m)
      super
    end

    def respond_to_missing?(m, *)
      keys.include?(m) || super
    end

  end
end
