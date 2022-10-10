module Resolving
  module Imaging

    def to_image
      empty_image.tap do |m|
        m.predecessor = self
        m.cache_identifiers!
      end
    end

    def empty_image = image_class.new
    def image_class = ::Images::Image

  end
end
