module Streaming
  module Consuming

    def consume(callback)
      File.open(path, 'r').tap { |f| follow(f, callback) }
    end

    protected

    def follow(file, callback)
      select([file])
      loop do
        sleep 0.01
        file.gets.tap do |line|
          next unless line
          return if is_eot?(line)
          callback.call(line)
        end
      end
    end

    def is_eot?(line) = line[0] == eot

  end
end
