require 'io/console'

module Streaming
  class Outputting < ::Spaces::Space
    include Producing

    def initialize(stream)
      @stream = stream
    end

    def init
      print("\033[?25l")
    end

    def close
      print("\033[?25h")
    end

    def error(message)
      print("\033[0;33m#{message}\033[0m")
    end

    def exception
      # Do nothing. Exception logged elsewhere.
    end

    def output(line)
      verbose? ? print(line) : progress_line(line)
    end

    def progress_line(line)
      line.split(/\R+/).each { |r| progress_row(r) }
    end

    def progress_row(row)
      max = IO.console.winsize[1] - 1
      text = "\033[0;34m#{spinner}\033[0m #{row.gsub(/\P{ASCII}/, '')}"[0...max]
      clear_row
      print("#{text}\r")
    end

    def clear_row
      print("\033[2K")
    end

    def spinner
      '⠋⠙⠸⢰⣠⣄⡆⠇'[spin]
    end

    def spin
      return @spin = 0 if @spin == 7
      @spin = @spin.to_i + 1
    end

    def verbose?
      @stream.streaming.input[:verbose]
    end

  end
end
