module Divisions
  class Image < ::Emissions::Subdivision

    class << self
      def safety_overrides = {}

      def constant_for(type)
        Module.const_get("::Providers::#{type.to_s.camelize}::Image")
      end
    end

    delegate(
      safety_overrides: :klass,
      tenant: :emission
    )

    def identifier = type

    def export = emit
    def commit = emit

    def complete? = !(type && image).nil?

    def default_output_image = "spaces/#{default_name}:#{default_tag}"

    def default_tag = 'latest'

    def post_processor_stanzas = nil

    def initialize(struct:, division:)
      self.division = division
      self.struct = OpenStruct.new(default_resolution).merge(struct.merge(OpenStruct.new(safety_overrides)))
    end

    def default_resolution = @default_resolution ||= {}

  end
end
