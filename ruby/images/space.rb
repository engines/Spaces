require_relative '../spaces/space'

module Images
  class Space < ::Spaces::Space

    def save(model)
      model.all_scripts.map do |s|
        super(s)
        "#{s.path}"
      end
    end

  end
end
