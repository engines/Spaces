module Divisions
  class PostProcessors < ::Divisions::Divisible

    delegate(images: :emission)

    def to_h; payloads.map(&:to_h) ;end

    def payloads
      images.all.map {|i| i.post_processor_payloads }.compact
    end

  end
end
