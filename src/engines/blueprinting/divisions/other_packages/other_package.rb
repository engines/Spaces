module Divisions
  class OtherPackage < ::Emissions::Subdivision
    include ::Packing::Division

    delegate(
      # [:branch, :repository, :protocol, :git?] => :target
      repository: :target
    )

    def emit
      super.tap { |s| s[:target] = target.struct }
    end

    def target; @target ||= descriptor_class.new(struct.target) ;end
    # def identifier; struct.identifier || target.identifier ;end
    #
    # def extraction; struct.extraction ||= protocol ;end
    # def extracted_path; struct.extracted_path ||= identifier ;end

    # def defaults
    #   @defaults = {
    #     identifier: target.identifier,
    #     extraction: protocol,
    #     extracted_path: identifier ;end
    #   }
    # end

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
