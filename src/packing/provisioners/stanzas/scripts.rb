require_relative '../../../emitting/emissions/stanza'

module Packing
  module Provisioners
    module Stanzas
      class Scripts < ::Emitting::Stanza

        delegate(script_file_names: :emission)

        def to_h
          if script_file_names.any?
            [
              {
                type: 'file',
                source: 'scripts/',
                destination: 'tmp'
              },
              {
                type: 'shell',
                scripts: script_file_names
              }
            ]
          end
        end

      end
    end
  end
end
