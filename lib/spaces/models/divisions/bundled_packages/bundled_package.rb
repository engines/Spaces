module Divisions
  class BundledPackage < ::Divisions::Subdivision

    class << self
      def features = [:identifier, :target, :extraction, :extracted_path, :destination]

      def class_for(type) = super(:divisions, type.to_s.camelize)
    end

    delegate(
      [:repository, :format, :git?] => :target
    )

    def dynamic_type =
      klass.class_for(format).new(struct: struct, division: division)

    def target
      @target ||= descriptor_class.new(struct.target)
    end

    def identifier = struct.identifier || derived_features[:identifier]

    def environment_vars
      [:repository, :extraction, :extracted_path, :destination].map do |v|
        division.send(v) if division.respond_to?(v)
      end
    end

    def inflated = super.tap { |s| s.target = target.struct }
    def deflated = super.tap { |s| s.target = target.struct }

    protected

    def derived_features
      @derived_features ||= {
        identifier: target.identifier,
        extraction: format,
        extracted_path: target.identifier
      }
    end

  end
end
