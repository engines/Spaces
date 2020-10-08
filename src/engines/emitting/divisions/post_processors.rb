module Divisions
  class PostProcessors < ::Emissions::Divisible

    delegate(images: :emission)

    def emit
      stanzas.map(&:to_h)
    end

    def stanzas
      images.all.map {|i| i.post_processor_stanzas }.compact
    end

  end
end
