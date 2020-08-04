require_relative '../../../releases/stanza'

module Packing
  module Provisioners
    module Stanzas
      class Scripts < ::Releases::Stanza

        def to_h
          [
            {
              type: 'file',
              source: "#{directory}/",
              destination: 'tmp'
            },
            {
              type: 'shell',
              scripts: locations
            }
          ]
        end

        def locations
          collaboration.file_names_for(directory).map do |n|
            "#{directory}/#{n.split('/').last}"
          end
        end

        def directory; :scripts ;end

      end
    end
  end
end
