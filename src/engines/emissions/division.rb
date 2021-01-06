require_relative 'transformable'

module Emissions
  class Division < Transformable

    include Engines::Logger

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
      logger.debug "auxiliary_directories: #{auxiliary_directories.inspect}"

      auxiliary_directories.map do |d|
        auxiliary_paths_for(d).map do |p|
          logger.debug "auxiliary_paths_for(#{d}): #{p.inspect}"
          Interpolating::FileText.new(origin: p, directory: d, transformable: self)
        end
      end.flatten
    end

    def with_embeds
      emission.embeds.reduce(itself) do |r, b|
        r.tap do |rp|
          rp.embed!(b.send(qualifier)) if b.has?(qualifier)
        end
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
      Pathname(__dir__).dirname.join('blueprinting', 'divisions', qualifier)
    end

    def initialize(emission:, struct: nil, label: nil)
      self.emission = emission
      self.label = label
      self.struct = struct || emission.struct[label] || default_struct
    end

    def to_s; struct ;end

  end
end
