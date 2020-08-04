require_relative '../../../releases/stanza'

module Packing
  module Provisioners
    module Stanzas
      class Files < ::Releases::Stanza

        def to_h
          {
            type: 'file',
            source: 'files',
            destination: 'tmp/'
          }
        end

      end
    end
  end
end
