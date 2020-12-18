require_relative 'transformable'

module Emissions
  class Division < Transformable

    attr_accessor :label

    class << self
      def prototype(emission:, label:)
        emission.maybe_with_embeds_in(new(emission: emission, label: label))
      end

      def default_struct; OpenStruct.new ;end
    end

    relation_accessor :emission

    delegate(
      default_struct: :klass,
      composition: :emission,
      ranking: :composition,
      resolutions: :universe
    )

    def packing_division?
      klass.ancestors.include?(::Packing::Division)
    end

    def composition_rank; ranking.index(klass) ;end

    def context_identifier; emission.context_identifier ;end

    def auxiliary_content
      auxiliary_directories.map do |d|
        auxiliary_paths_for(d).map do |p|
          Interpolating::FileText.new(origin: p, directory: d, transformable: self)
        end
      end.flatten
    end

    def with_embeds
      begin
        emission.embeds.reduce(itself) do |r, e|
          r.tap do |rp|
            rp.embed!(e.send(qualifier)) if e.has?(qualifier)
          end
        end
      rescue TypeError => e
        just_print_the_error(__FILE__, __LINE__, e)
      end
    end

    def embed!(other); itself; end

    def scale &block
      Array.new(emission.count) do |i|
        block.call(i)
      end
    end

    def auxiliary_paths_for(symbol)
      auxiliary_path.join(symbol).glob("**/*").reject(&:directory?)
    end

    def auxiliary_path
      PN(__dir__).dirname.join("blueprinting", "divisions", qualifier)
    end

    def initialize(emission:, struct: nil, label: nil)
      self.emission = emission
      self.label = label
      self.struct = struct || emission.struct[label] || default_struct
    end

    def to_s; struct ;end

  end
end
