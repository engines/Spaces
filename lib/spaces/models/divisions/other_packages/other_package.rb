module Divisions
  class OtherPackage < ::Divisions::Subdivision

    class << self
      def features = [:identifier, :target, :extraction, :extracted_path, :destination]
    end

    delegate(
      [:branch, :repository, :protocol, :git?] => :target
    )

    def target
      @target ||= descriptor_class.new(struct.target)
    end

    def identifier = struct.identifier || derived_features[:identifier]

    def extraction
      struct.extraction ||= derived_features[:extraction]
    end

    def extracted_path
      struct.extracted_path ||= derived_features[:extracted_path]
    end

    def inflated = super.tap { |s| s.target = target.struct }
    def deflated = super.tap { |s| s.target = target.struct }

    protected

    def derived_features
      @derived_features ||= {
        identifier: target.identifier,
        extraction: protocol,
        extracted_path: target.identifier
      }
    end

  end
end
