require_relative 'embeddable'
require_relative 'resolvable'

module Divisions
  class Division < ::Transforming::Transformable
    include Embeddable
    include Resolvable

    class << self
      def dynamic_type(emission:, label:) = new(emission: emission, label: label)

      def default_struct = OpenStruct.new
    end

    relation_accessor :emission
    attr_accessor :label

    delegate(
      default_struct: :klass,
      ranking: :composition,
      [:auxiliary_directories] => :emission,
      resolutions: :universe
    )

    def context_identifier = emission.context_identifier

    def localized = self
    def globalized = self

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

    def path = nil

    def empty =
      self.class.new(emission: emission, struct: default_struct, label: label)

    def any? = !empty?
    def empty? = struct == OpenStruct.new

    def inflated =
      duplicate(self).tap { |s| s.struct = s.struct.merge(inflatables) }

    def deflated =
      empty.tap { |s| s.struct = OpenStruct.new(deflatables) }

    def merge(other) = struct.merge(other.struct)

    def initialize(emission:, struct: nil, label: nil)
      self.emission = emission
      self.label = label
      self.struct = struct || emission.struct[label] || default_struct
    end

    def deep_to_struct = struct.deep_to_struct

    def to_s = struct

    def method_missing(m, *args, &block)
      emission.respond_to?(m) ? emission.send(m, *args, &block) : super
    end

    def respond_to_missing?(m, *)
      emission.respond_to?(m) || super
    end

  end
end
