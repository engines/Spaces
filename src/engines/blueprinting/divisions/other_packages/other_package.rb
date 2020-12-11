module Divisions
  class OtherPackage < ::Emissions::Subdivision
    include ::Packing::Division

    delegate(
      [:branch, :repository, :extension, :git?] => :descriptor
    )

    def descriptor; @descriptor ||= descriptor_class.new(struct.descriptor) ;end
    def identifier; struct.identifier || descriptor.identifier ;end

    def extraction; struct.extraction ||= extension ;end
    def extracted_path; struct.extracted_path ||= identifier ;end

    def packing_stanza
      {
        type: 'shell',
        environment_vars: environment_vars,
        inline: ["#{division.temporary_script_path}/add"]
      }
    end

    def environment_vars
      [:repository, :extraction, :extracted_path, :destination].map do |v|
        "#{v}=#{send(v) if respond_to?(v)}"
      end
    end

  end
end
