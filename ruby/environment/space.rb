require_relative 'environment'
require_relative '../spaces/space'

module Environment
  class Space < ::Spaces::Space
    # The dimensions in which a running version of a software product can exist as a single entity

    def by(descriptor)
      model_class.new.tap do |m|
        m.struct = OpenStruct.new.tap do |s|
          s.locale = OpenStruct.new.tap do |s|
            s.language = 'en_AU:en'
            s.lang = 'en_AU.UTF8'
            s.lc_all = 'en_AU.UTF8'
          end
        end
      end
    end

    def model_class
      Environment
    end

  end
end
