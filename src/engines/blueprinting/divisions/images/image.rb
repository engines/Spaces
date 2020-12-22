module Divisions
  class Image < ::Emissions::Subdivision

    class << self
      def safety_overrides; {} ;end

      def constant_for(type)
        Module.const_get("::Providers::#{type.to_s.camelize}::Image")
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

    def default_tag
      'latest'
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
