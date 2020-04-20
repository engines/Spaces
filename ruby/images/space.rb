require_relative '../docker/images/space'

module Images
  class Space < ::Spaces::Space

    delegate([:all, :from_subject, :from_tar] => :bridge)

    def by(descriptor)
      bridge.get(descriptor.identifier)
    end

    def save(subject)
      subject.product.map do |t|
        save_text(t)
        "#{t.product_path}"
      end
    end

    def bridge
      @bridge ||= Docker::Images::Space.new(self)
    end

  end
end
