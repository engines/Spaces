module Divisions
  class OtherPackage < ::Divisions::Subdivision
    include ::Packing::Division

    class << self
      def features; [:identifier, :target, :extraction, :extracted_path, :destination] ;end
    end

    delegate(
      [:branch, :repository, :protocol, :git?] => :target
    )

    def target; @target ||= descriptor_class.new(struct.target) ;end
    def identifier; struct.identifier || derived_features[:identifier] ;end

    def extraction; struct.extraction ||= derived_features[:extraction] ;end
    def extracted_path; struct.extracted_path ||= derived_features[:extracted_path] ;end

    # PACKER-SPECIFIC
    def packing_artifact
      {
        type: 'shell',
        environment_vars: environment_vars,
        inline: ["#{division.temporary_script_path}/#{division.qualifier}/add"]
      }
    end

    # PACKER-SPECIFIC
    def environment_vars
      [:repository, :extraction, :extracted_path, :destination].map do |v|
        "#{v}=#{send(v) if respond_to?(v)}"
      end
    end

    def inflated; super.tap { |s| s.target = target.struct } ;end
    def deflated; super.tap { |s| s.target = target.struct } ;end

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
