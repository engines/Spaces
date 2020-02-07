require_relative '../spaces/space'

module Images
  class Space < ::Spaces::Space

    def save(model)
      model.scripts.map do |s|
        super(s)
        "#{s}"
      end
    end

  end
end
