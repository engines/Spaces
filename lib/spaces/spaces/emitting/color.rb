module Spaces
  module Emitting
    module Color
      Colors = {
        black: '30',
        red: '31',
        green: '32',
        yellow: '33',
        blue: '34',
        magenta: '35',
        cyan: '36',
        white: '37',
      }

      def self.method_missing(m, text, bold: false)
        "\033[#{bold ? 1 : 0};#{Colors[m]}m#{text}\033[0m"
      end
    end
  end
end
