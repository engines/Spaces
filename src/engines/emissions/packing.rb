module Emissions
  module Packing

    def packed
      empty_pack.tap do |m|
        m.predecessor = self
        m.struct = (has?(:images) ? struct_for(images) : OpenStruct.new)
        m.struct.identifier = identifier
      end
    end

    def struct_for(images); OpenStruct.new(builders: images.all.map(&:inflated).map(&:struct)) ;end

    def packing_divisions
      divisions.select { |d| d.packing_division? }.sort_by(&:composition_rank)
    end

    def empty_pack; packing_class.new ;end
    def packing_class; ::Packing::Pack ;end

  end
end
