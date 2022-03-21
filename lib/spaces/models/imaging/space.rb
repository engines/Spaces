module Imaging
  class Space < ::Packing::Space

    delegate(
      packs: :universe,
      path: :packs,
    )

    def interface_for(pack)  #TODO: refactor
      pack.arena.packing_provider.interface_for(pack, purpose: :imaging, space: space)
    end

  end
end
