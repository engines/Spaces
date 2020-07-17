require_relative 'client'
require_relative '../spaces/space'

module Clients
  class Space < ::Spaces::Space

    def by(descriptor, klass = default_model_class)
      klass.new.tap do |m|
        m.struct = m.default
      end
    end

    def default_model_class
      Client
    end

  end
end
