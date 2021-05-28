# PACKER-SPECIFIC
module Divisions
  class PostProcessors < ::Divisions::Divisible

    delegate(images: :emission)

    def to_h; artifacts.map(&:to_h) ;end

    def artifacts
      images.all.map(&:provider_aspect).map {|i| i.post_processor_artifacts }.compact
    end

  end
end
