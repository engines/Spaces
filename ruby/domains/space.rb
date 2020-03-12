require_relative 'domain'
require_relative '../spaces/space'

module Domains
  class Space < ::Spaces::Space

    def by(descriptor, klass = model_class)
      klass.new.tap do |m|
        m.struct = OpenStruct.new.tap do |s|
          s.name = 'current.spaces.org'
        end
      end
    end

    def model_class
      Domain
    end

  end
end
