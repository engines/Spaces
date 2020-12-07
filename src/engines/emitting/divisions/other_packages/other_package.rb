module Divisions
  class OtherPackage < ::Emissions::Subdivision

    delegate(
      [:branch, :repository, :extension, :destination_path, :git? ] => :descriptor
    )

    def descriptor; @descriptor ||= descriptor_class.new(struct.descriptor) ;end
    def identifier; struct.identifier || descriptor.identifier ;end

    def extraction; struct.extraction ||= extension ;end
    def extracted_path; struct.extracted_path ||= identifier ;end

  end
end
