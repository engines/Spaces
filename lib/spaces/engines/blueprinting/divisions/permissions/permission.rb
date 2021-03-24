module Divisions
  class Permission < ::Divisions::Subdivision
    include ::Packing::Division

    def packing_payload
      {
        type: 'shell',
        inline: [
          ("chown #{recursion} #{ownership} #{file}" if ownership),
          ("chmod #{recursion} #{mode} #{file}" if mode)
        ].compact
      }
    end

    def recursion; '-R' if struct.recursion ;end

  end
end
