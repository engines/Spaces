require_relative '../spaces/space'
require_relative '../docker/image_space'

module Images
  class Space < ::Spaces::Space

    def save(subject)
      subject.product.map do |t|
        save_text(t)
        "#{t.product_path}"
      end
    end

    def from_subject(subject)
      bridge.from_directory(path_for(subject))
    end

    def from_tar(subject)
      bridge.from_tar(path_for(subject))
    end

    def bridge
      @bridge ||= Docker::ImageSpace.new
    end

  end
end
