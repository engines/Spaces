module Divisions
  class Image < ::Emissions::Subdivision

    class << self
      def safety_overrides; {} ;end

      def constant_for(struct:)
        Module.const_get("/providers/#{struct.type}/image".camelize)
      end
    end

    delegate(
      safety_overrides: :klass,
      tenant: :emission
    )

    def identifier; type ;end

    def export; emit ;end
    def commit; emit ;end

    def complete?
      !(type && image).nil?
    end

    def default_output_image
      "spaces/#{default_name}:#{default_tag}"
    end

    def default_name
      "#{tenant.identifier}/#{context_identifier}"
    end

    def default_tag
      'latest'
    end

    def packing_script_file_names
      if struct.scripts
        scripts.to_h.reduce([]) do |m, v|
          m << v.last.map { |l| "scripts/#{v.first}/#{l}" }
        end.flatten
      else
        []
      end
    end

    def post_processor_stanzas; end

    def initialize(struct:, division:)
      self.division = division
      self.struct = OpenStruct.new(default_resolution).merge(struct.merge(OpenStruct.new(safety_overrides)))
    end

    def default_resolution
      @default_resolution ||= {}
    end

  end
end
