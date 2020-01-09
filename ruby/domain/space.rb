require_relative 'domain'
require_relative '../spaces/space'

module Domain
  class Space < ::Spaces::Space
    # The dimensions in which a running version of a software product can exist as a single entity

    def by(descriptor)
      model_class.new.tap do |m|
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
