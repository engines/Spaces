require_relative '../../../releases/stanza'

module Packing
  module PostProcessors
    module Stanzas
      class DockerTags < ::Releases::Stanza

        def to_h
          matching_images.map do |i|
            {
              type: "#{i.type}-tag",
              repository: i.image,
              tags: 'latest'
            }
          end
        end

        def matching_images
          release.images.all.select { |i| matching_types.include?(i.type) }
        end

        def matching_types
          [:docker]
        end

      end
    end
  end
end
