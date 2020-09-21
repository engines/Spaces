require_relative '../emitting/divisible'
require_relative 'binding'

module Bindings
  class Bindings < ::Emitting::Divisible

    def named(name)
      all.detect { |b| b.identifier == name.to_s }
    end

    def resolutions
      all.map(&:resolution)
    end

    def method_missing(m, *args, &block); named(m) || super ;end
    def respond_to_missing?(m, *); named(m) || super ;end

  end
end
