module Config

  def self.mount( rack )

    rack.map('/node_modules') { run Rack::Directory.new('node_modules') }
    rack.map('/api') { run Server::Api }
    rack.map('/') { run Server::Client }

  end

end
