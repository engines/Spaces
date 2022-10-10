require 'io/console'
require_relative 'stream'

module Streaming
  class OutputStream < Stream
    include Producing

    def init = hide_cursor
    def close = show_cursor

    def verbose? = command.input[:verbose]

    def error(line) =
      print("\033[0;33m#{line}\033[0m")

    # The << method is so stream behaves like STDOUT
    def << (line) = output(line)

    def exception
      # Do nothing. Exception logged elsewhere.
    end

    def output(line) =
      verbose? ? print(line) : progress_line(line)

    def progress_line(line) =
      line.split(/\R+/).each { |r| progress_row(r) }

    def progress_row(row)
      max = IO.console.winsize[1] - 1
      text = "\033[0;34m#{spinner}\033[0m #{row.gsub(/\P{ASCII}/, '')}"[0...max]
      clear_row
      print("#{text}\r")
    end

    def hide_cursor = print("\033[?25l")
    def show_cursor = print("\033[?25h")
    def clear_row = print("\033[2K")

    def spinner = '⠋⠙⠸⢰⣠⣄⡆⠇'[spin]

    def spin
      return @spin = 0 if @spin == 7
      @spin = @spin.to_i + 1
    end

  end
end
