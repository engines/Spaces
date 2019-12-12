require 'yaml'
require 'yajl/json_gem'
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

    def identifier
      self.class.identifier
    end

    def to_memo
      to_h(memo_variables)
    rescue SystemStackError => e
    end

    def to_yaml
      YAML.dump(to_memo)
    end

    def memo_variables
      []
    end

    private

    def to_h(variables)
      variables.each_with_object({}) do |i, h|
        ivv = instance_variable_get(i)

        h[i.to_s.delete('@')] =
          if ivv.is_a? Model
            ivv.to_memo
          elsif ivv.is_a? Array
            ivv.map { |v| v.respond_to?(:to_h) ? v.to_h : v }
          elsif ivv.is_a? Hash
            ivv.transform_values { |v| v.respond_to?(:to_h) ? v.to_h : v }
          else
            ivv
          end
      end
    end

  end
end
