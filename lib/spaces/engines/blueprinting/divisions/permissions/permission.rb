module Divisions
  class Permission < ::Divisions::Subdivision
    include ::Packing::Division

    class << self
      def features; [:file, :mode, :ownership] ;end
    end

    # PACKER-SPECIFIC
    def packing_artifact
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
