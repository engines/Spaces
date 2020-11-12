require_relative 'transformable'

module Emissions
  class Division < Transformable

    attr_accessor :label

    class << self
      def prototype(emission:, label:)
        new(emission: emission, label: label).embedded
      end

      def packing_script_file_names; [] ;end
      def default_struct; OpenStruct.new ;end
    end

    relation_accessor :emission

    delegate(
      [:packing_script_file_names, :default_struct] => :klass,
      [:context_identifier, :interpolating_class] => :emission
    )

    def auxiliary_content
      auxiliary_directories.map do |d|
        auxiliary_paths_for(d).map do |p|
          interpolating_class.new(origin: p, directory: d, division: self)
        end
      end.flatten
    end

    def embedded
      emission.embeds.reduce(itself) do |r, e|
        r.tap do |r|
          r.embed(e.send(qualifier)) if e.has?(qualifier)
        end
      end
    end

    def embed(other); itself; end

    def scale &block
      Array.new(emission.count) do |i|
        block.call(i)
      end
    end

    def auxiliary_paths_for(symbol)
      Pathname.glob("#{__dir__.split('emissions').first}divisions/#{qualifier}/#{symbol}/**/*").reject { |p| p.directory? }
    end

    def initialize(emission:, struct: nil, label: nil)
      self.emission = emission
      self.label = label
      self.struct = struct || emission.struct[label] || default_struct
    end

    def to_s; struct ;end

  end
end
