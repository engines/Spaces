module Arenas
  module Images

    def build_from(**args)
      empty.tap do |m|
        m.struct = struct
        m.struct.tap do |s|
          s.images =
            [OpenStruct.new(args), s.images].flatten.compact.uniq
        end
      end
    end

  end
end
