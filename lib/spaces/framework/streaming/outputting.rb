require 'io/console'

module Streaming
  class Outputting < ::Spaces::Space

    def init; end
    def close; end

    def produce(&block)
      yield(self)
    # rescue => e
    #   exception(e)
    end

    def error(message)
      print("\033[0;33m#{message}\033[0m\n")
    end

    # def exception(e)
    #   print("\033[0;31m#{e.backtrace}\n#{e}\033[0m\n")
    # end

    def output_lines_from(io)
      io.each_line { |l| output(l) }
      clear_row
    end

    def output(line)
      line.split(/\R+/).each do |row| # split line into terminal rows
        max = IO.console.winsize[1] - 2
        r = " #{row.gsub(/\P{ASCII}/, '')[0...max]}"
        clear_row
        print_row(r)
      end
    end

    def print_row(row)
      print("#{row}\r")
    end

    def clear_row
      print("\033[K")
    end

    def initialize(streaming)
      @streaming = streaming
    end

  end
end
