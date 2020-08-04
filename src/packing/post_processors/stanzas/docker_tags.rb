require_relative '../../../releases/stanza'

module Packing
  module PostProcessors
    module Stanzas
      class DockerTags < ::Releases::Stanza

        def to_h
          matching_images.map do |b|
            {
              type: "#{b.type}-tag",
              repository: collaboration.repository_name,
              tags: 'latest'
            }
          end
        end

        def matching_images
          collaboration.images.all.select { |i| matching_types.include?(i.type) }
        end

        def matching_types
          [:docker]
        end

      end
    end
  end
end
