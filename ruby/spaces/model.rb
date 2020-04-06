require 'forwardable'
require 'yaml'
require 'json'
require 'duplicate'
require_relative '../lib/ostruct'
require_relative '../lib/string'
require_relative 'error'

module Spaces
  class Model
    extend Forwardable

    class << self
      def universe
        @@universal_space ||= Universal::Space.new
      end

      def identifier
        name.split('::').join
      end

      def qualifier
        name.split('::').last.gsub(/([^\^])([A-Z])/,'\1_\2').downcase
      end

      def subspace_path_method
        :identifier
      end

      def from_yaml(yaml)
        YAML::load(yaml)
      end

      def relation_accessor(*args)
        attr_accessor(*args)
      end

      def alias_accessor(to, from)
        alias_method to, from
        alias_method "#{to}=", "#{from}="
      end
    end

    attr_accessor :struct, :klass
    relation_accessor :descriptor

    alias_method :product, :itself

    delegate(
      [:universe, :qualifier] => :klass
    )

    def descriptor
      @descriptor ||= descriptor_class.new(struct.descriptor)
    end

    def uniqueness
      [klass.name, identifier]
    end

    def file_path
      "#{subspace_path}/#{klass.identifier}"
    end

    def subspace_path
      send(klass.subspace_path_method)
    end

    def namespaced_name(namespace, symbol)
      "#{namespace}::#{symbol.to_s.split('_').map(&:capitalize).join}"
    end

    def to_yaml
      YAML.dump(struct)
    end

    def open_struct_from_json(json)
      JSON.parse(json, object_class: OpenStruct)
    end

    def descriptor_class
      Descriptor
    end

    def klass
      @klass ||= self.class
    end

    def initialize(struct: nil)
      self.struct = struct
    end

    def to_s
      identifier
    end

    def method_missing(m, *args, &block)
      if struct&.to_h&.keys&.include?(m)
        struct.send(m, *args, &block)
      else
        super
      end
    end

  end
end
