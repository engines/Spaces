require_relative '../../../../emitting/emissions/stanza'

module Packing
  module Provisioners
    module Stanzas
      class Injections < ::Emissions::Stanza

        def to_h
          {
            type: 'file',
            source: 'injections',
            destination: 'tmp/'
          }
        end

      end
    end
  end
end
