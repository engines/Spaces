require 'io/console'
require_relative 'stream'

module Streaming
  class OutputStream < Stream
    include Producing

    def init = hide_cursor
    def close
      clear_row if !verbose?
      show_cursor
    end

    def verbose? = command.input[:verbose]

    def print(line) = super(line.force_encoding("UTF-8"))

    def error(line) =
      print("\e[33m#{line}\e[0m")

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
      text = "\e[34m#{spinner}\e[0m #{row.gsub(/\P{ASCII}/, '')}"[0...max]
      clear_row
      print("#{text}\r")
    end

    def hide_cursor = print("\e[?25l")
    def show_cursor = print("\e[?25h")
    def clear_row = print("\e[2K")

    def spinner = '⠋⠛⠙⠹⠸⠼⠴⠶⠦⠧⠇⠏'[spin]

    def spin = @spin == 12 ? @spin = 0 : @spin = @spin.to_i + 1

  end
end
