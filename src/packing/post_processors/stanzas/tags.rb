require_relative '../../../releases/stanza'

module Packing
  module PostProcessors
    module Stanzas
      class Tags < ::Releases::Stanza

        def to_h
          collaboration.builders.all.map do |b|
            {
              type: "#{b.type}-tag",
              repository: collaboration.repository_name,
              tags: 'latest'
            }
          end
        end

      end
    end
  end
end
