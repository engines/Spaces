module Streaming
  module Writing

    def output(line)
      line.split(/\r/).each do |r| # split line into terminal rows
        append(encoded_output_for("#{r}\r"))
      end
    end

    def error(line)
      append(encoded_error_for(line))
    end

    def exception
      append(encoded_exception)
    end

    def init
      path.dirname.mkpath
      File.open(path, 'w') {}
    end

    def close
      append(eot)
    end

    protected

    def append(line)
      File.open(path, 'a') { |f| f.write("#{line}\n") }
    end

    def encoded_output_for(line) = {output: line}.to_json

    def encoded_error_for(line) = {error: line}.to_json

    def encoded_exception = {exception: "Server error. Command output streaming failed."}.to_json

  end
end
