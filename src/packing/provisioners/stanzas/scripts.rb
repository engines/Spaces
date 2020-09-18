require_relative '../../../releases/stanza'

module Packing
  module Provisioners
    module Stanzas
      class Scripts < ::Releases::Stanza

        delegate(script_file_names: :release)

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
