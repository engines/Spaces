require_relative '../../releases/subdivision'

module Packing
  module Images
    class Image < ::Releases::Subdivision

      class << self
        def safety_overrides; {} ;end
      end

      delegate(safety_overrides: :klass)

      def identifier; type ;end

      def export; memento ;end
      def commit; memento ;end

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
