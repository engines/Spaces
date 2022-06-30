module Streaming
  module Producing

    def produce(&block)
      yield(self)
    rescue => e
      exception(e)
    end

    def output_lines_from(io)
      io.each_line { |l| output(l) }
    end

    def output(line)
      line.split("\r").each do |r| # split line into terminal rows
        append(encoded_output_for("#{r}\r"))
      end
    end

    def error(line)
      append(encoded_error_for(line))
    end

    def exception(e)
      append(encoded_exception_for(e))
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

    def encoded_output_for(line)
      {output: line}.to_json
    end

    def encoded_error_for(line)
      {error: line}.to_json
    end

    def encoded_exception_for(e)
      {exception: exception_message_for(e)}.to_json
    end

    def exception_message_for(e)
      [e.message, *e.backtrace].join("\n")
    end

  end
end
