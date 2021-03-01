module Divisions
  class OtherPackage < ::Divisions::Subdivision
    include ::Packing::Division

    delegate(
      [:branch, :repository, :protocol, :git?] => :target
    )

    def target; @target ||= descriptor_class.new(struct.target) ;end
    def identifier; struct.identifier || target.identifier ;end

    def extraction; struct.extraction ||= protocol ;end
    def extracted_path; struct.extracted_path ||= identifier ;end

    def packing_stanza
      {
        type: 'shell',
        environment_vars: environment_vars,
        inline: ["#{division.temporary_script_path}/#{division.qualifier}/add"]
      }
    end

    def environment_vars
      [:repository, :extraction, :extracted_path, :destination].map do |v|
        "#{v}=#{send(v) if respond_to?(v)}"
      end
    end

  end
end
