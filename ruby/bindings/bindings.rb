require_relative '../collaborators/division'
require_relative 'binding'

module Bindings
  class Bindings < ::Collaborators::Division

    class << self
      def step_precedence
        { late: [:runs] }
      end

      def inheritance_paths; __dir__; end
    end

    require_files_in :steps, :scripts

    def layers_for(group)
      [super, all.map { |a| a.layers_for(group) }]
    end

    def named(name)
      all.detect { |b| b.identifier == name.to_s }
    end

    def product
      all.map { |a| a.product }
    end

    def persistent(symbol)
      all.inject({}) do |m, b|
        m[b.identifier] = b.struct.dig(:persistent, symbol)
        m
      end.compact
    end

    def method_missing(m, *args, &block)
      named(m) || super
    end

  end
end
