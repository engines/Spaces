module Streaming
  module Writing

    def output(line)
      line.match(/\r/) ? returning_line(line) : append(encoded_output_for(line))
    end

    def returning_line(line)
      line.split(/\r/).tap do |rows|
        last = rows.count - 1
        rows.each.with_index do |r, i|
          append(encoded_output_for(i == last ? r : "#{r}\r"))
        end
      end
    end

    def error(line)
      append(encoded_error_for(line))
    end

    # The << method is so stream behaves like STDOUT
    def << (line)
      append(encoded_output_for(line))
    end

    def exception
      append(encoded_exception)
    end

    def init
      stream_path.dirname.mkpath
      File.open(stream_path, 'w') {}
    end

    def stream_path =
      dirname.join("#{identifier.as_path}.#{default_extension}")

    def default_extension = :out

    def close = append(eot)

    protected

    def append(line)
      File.open(stream_path, 'a') { |f| f.write("#{line}\n") }
    end

    def encoded_output_for(line) = {output: line}.to_json

    def encoded_error_for(line) = {error: line}.to_json

    def encoded_exception = {exception: "Server error. Command output streaming failed."}.to_json

  end
end
