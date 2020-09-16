require_relative '../../../releases/stanza'

module Packing
  module Provisioners
    module Stanzas
      class Injections < ::Releases::Stanza

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
