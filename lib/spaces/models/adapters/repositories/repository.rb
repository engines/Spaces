require_relative '../package_access'

module Adapters
  class Repository < PackageAccess

    class << self
      def dynamic_type(division) =
        class_for(division.type).new(division)

      def class_for(type) = super(:adapters, type.to_s.camelize, qualifier)
    end

    delegate(
      content: :struct,
      [:configure, :clean] => :accessor
    )

    alias_method :accessor_name, :content

    def default_accessor_class = ::Packaging::Installer

  end
end
