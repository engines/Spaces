require_relative '../spaces/space'

module Images
  class Space < ::Spaces::Space

    def deep_save(subject)
      subject.product.map do |t|
        save(t)
        "#{t.path}"
      end
    end

  end
end
