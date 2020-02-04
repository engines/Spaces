require_relative '../spaces/space'

module Image
  class Space < ::Spaces::Space

    def save(model)
      model.scripts.each { |s| super(s) }
    end

  end
end
