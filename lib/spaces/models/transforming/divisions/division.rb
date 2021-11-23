require_relative 'embeddable'
require_relative 'resolvable'

module Divisions
  class Division < ::Transforming::Transformable
    include Engines::Logger
    include Embeddable
    include Resolvable

    class << self
      def prototype(emission:, label:)
        new(emission: emission, label: label)
      end

      def default_struct; OpenStruct.new ;end
    end

    relation_accessor :emission
    attr_accessor :label

    delegate(
      default_struct: :klass,
      ranking: :composition,
      [:auxiliary_directories] => :emission,
      resolutions: :universe
    )

    def context_identifier; emission.context_identifier ;end

    def localized; self ;end
    def globalized; self ;end

    def content
      auxiliary_directories.map do |d|
        auxiliary_paths_for(d)&.map do |p|
          Interpolating::FileText.new(origin: p, directory: d, transformable: self)
        end
      end.flatten
    end

    def auxiliary_paths_for(symbol)
      path.join("#{symbol}").glob("**/*").reject(&:directory?) if path
    end

    def path; ;end

    def empty; self.class.new(emission: emission, struct: default_struct, label: label) ;end

    def any?; !empty? ;end
    def empty?; struct == OpenStruct.new ;end

    def inflated
      duplicate(self).tap { |s| s.struct = s.struct.merge(inflatables) }
    end

    def deflated
      empty.tap { |s| s.struct = OpenStruct.new(deflatables) }
    end

    def merge(other); struct.merge(other.struct) ;end

    def initialize(emission:, struct: nil, label: nil)
      self.emission = emission
      self.label = label
      self.struct = struct || emission.struct[label] || default_struct
    end

    def method_missing(m, *args, &block)
      emission.respond_to?(m) ? emission.send(m) : super
    end

    def respond_to_missing?(m, *)
      emission.respond_to?(m) || super
    end

    def to_s; struct ;end

    def method_missing(m, *args, &block)
      emission.respond_to?(m) ? emission.send(m) : super
    end

    def respond_to_missing?(m, *)
      emission.respond_to?(m) || super
    end

  end
end
