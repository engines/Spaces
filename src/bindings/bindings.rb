require_relative '../releases/division'

module Bindings
  class Bindings < ::Releases::Division

    def named(name); all.detect { |b| b.identifier == name.to_s } ;end

    def method_missing(m, *args, &block); named(m) || super ;end
    def respond_to_missing?(m, *); named(m) || super ;end

  end
end
