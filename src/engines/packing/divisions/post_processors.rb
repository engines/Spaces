module Divisions
  class PostProcessors < ::Divisions::Divisible

    delegate(images: :emission)

    def to_h; stanzas.map(&:to_h) ;end

    def stanzas
      images.all.map {|i| i.post_processor_stanzas }.compact
    end

  end
end
