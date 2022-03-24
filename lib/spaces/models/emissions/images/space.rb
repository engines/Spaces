module Images
  class Space < ::Packing::Space

    def interface_for(image)  #TODO: refactor
      image.arena.runtime_provider.interface_for(image)
    end

  end
end
