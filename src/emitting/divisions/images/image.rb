require_relative '../../emissions/subdivision'

module Packing
  module Images
    class Image < ::Emitting::Subdivision

      class << self
        def safety_overrides; {} ;end
      end

      delegate(safety_overrides: :klass)

      def identifier; type ;end

      def export; emit ;end
      def commit; emit ;end

      def script_file_names
        if struct.scripts
          scripts.to_h.reduce([]) do |m, v|
            m << v.last.map { |l| "scripts/#{v.first}/#{l}" }
          end.flatten
        else
          []
        end
      end

      def initialize(struct:, division:)
        self.struct = OpenStruct.new(default_resolution).merge(struct.merge(OpenStruct.new(safety_overrides)))
        self.division = division
      end

      def default_resolution
        @default_resolution ||= {}
      end

    end
  end
end
