module Divisions
  class OtherPackage < ::Emissions::Subdivision
    include ::Packing::Division

    delegate(
      [:branch, :repository, :protocol, :git?] => :descriptor
    )

    def emit
      super.tap { |s| s[:descriptor] = descriptor.struct }
    end

    def descriptor = @descriptor ||= descriptor_class.new(struct.descriptor)
    def identifier = struct.identifier || descriptor.identifier

    def extraction = struct.extraction ||= protocol
    def extracted_path = struct.extracted_path ||= identifier

    def packing_stanza
      {
        type: 'shell',
        environment_vars: environment_vars,
        inline: [division.temporary_script_path.join('add')]
      }
    end

    def environment_vars
      [:repository, :extraction, :extracted_path, :destination].map do |v|
        "#{v}=#{send(v) if respond_to?(v)}"
      end
    end

  end
end
