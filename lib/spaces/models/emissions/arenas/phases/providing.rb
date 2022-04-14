module Arenas
  module Providing

    def provide_for(**args)
      empty.tap do |m|
        m.struct = struct
        m.struct.tap do |s|
          s.role_providers =
            [OpenStruct.new(args), s.role_providers].flatten.uniq(&:role_identifier)
        end
      end
    end

  end
end
