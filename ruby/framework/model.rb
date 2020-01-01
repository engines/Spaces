require 'yaml'
require 'json'
require 'ostruct'
require_relative '../framework/error'

module Framework
  class Model

    class << self
      def identifier
        name.split('::').join
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

    def initialize(struct = nil)
      self.struct = struct
    end

    def method_missing(m, *args, &block)
      if struct&.methods(false)&.include?(m)
        struct.send(m, *args, &block)
      else
        super
      end
    end

    def identifier
      self.class.identifier
    end

    def to_yaml
      YAML.dump(struct)
    end

    def open_struct_from_json(json)
      JSON.parse(json, object_class: OpenStruct)
    end
  end
end
