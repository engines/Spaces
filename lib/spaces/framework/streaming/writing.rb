module Streaming
  module Writing

    def output(line) = 
      line.match(/\r/) ? returning_line(line) : append(encoded(:output, line))

    def returning_line(line)
      line.split(/\r/).tap do |rows|
        last = rows.count - 1
        rows.each.with_index do |r, i|
          append(encoded(:output, i == last ? r : "#{r}\r"))
        end
      end
    end

    def error(line) = append(encoded(:error, line))

    # The << method is so stream behaves like STDOUT
    def << (line) = append(encoded(:output, line))

    def exception(e) = append(encoded_exception(e))

    def init
      stream_path.dirname.mkpath
      File.open(stream_path, 'w') {}
    end

    def stream_path = 
      dirname.join("#{identifier.as_path}.#{default_extension}")

    def default_extension = :out

    def close = append(eot)

    protected

    def append(line) = 
      File.open(stream_path, 'a') { |f| f.write("#{line}\n") }

    def encoded(key, line) = 
      {key => line.force_encoding("UTF-8")}.to_json

    def encoded_exception(e) = 
      {exception: [e.message, '', *e.backtrace].join("\n")}.to_json

  end
end
