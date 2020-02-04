require_relative '../spaces/space'

module Image
  class Space < ::Spaces::Space

    def save(model)
      model.scripts.each { |s| s.save }
    end

  end
end
