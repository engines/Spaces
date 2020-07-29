require_relative '../../../releases/stanza'

module Packing
  module PostProcessors
    module Stanzas
      class Tags < ::Releases::Stanza

        def to_h
          context.collaboration.builders.all.map do |b|
            {
              type: "#{b.type}-tag",
              repository: "#{b.collaboration.client.identifier}/#{b.collaboration.identifier}",
              tag: 'latest'
            }
          end
        end

      end
    end
  end
end
