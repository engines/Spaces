require_relative '../spaces/space'

module Images
  class Space < ::Spaces::Space

    alias_method :super_save, :save

    def save(model)
      model.product.map do |t|
        super_save(t)
        "#{t.path}"
      end
    end

  end
end
