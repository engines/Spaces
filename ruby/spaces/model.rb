require 'yaml'
require 'json'
require 'ostruct'
require_relative 'error'

module Spaces
  class Model

    class << self
      def identifier
        name.split('::').join
      end

      def unqualified_identifier
        name.split('::').last
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

    attr_accessor :struct
    relation_accessor :descriptor

    def initialize(struct = nil)
      self.struct = struct
    end

    def descriptor
      @descriptor ||= descriptor_class.new(struct.descriptor)
    end

    def identifier
      descriptor.identifier
    end

    def file_path
      "#{subspace_path}/#{self.class.identifier}"
    end

    def subspace_path
      identifier
    end

    def scoped_class(symbol)
      Module.const_get(scoped_class_name(scope_module_name, symbol))
    end

    def scoped_class_name(module_name, symbol)
      "#{module_name}::#{symbol.to_s.split('_').map { |i| i.capitalize }.join}"
    end

    def scope_module_name
      self.class.name
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

    def universe
      @universal_space ||= Universal::Space.new
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
