module App

  def self.require_files(path)
    collect_files(path).each do |file|
      require(file)
    end
  end

  def self.concatenate_files(path)
    collect_files(path).map do |file|
      File.read(file)
    end.join("\n")
  end

  def self.collect_files(path)
    Dir.glob([path]).select do |file|
      File.file?(file)
    end.sort do |a, b|
      a.count('/') <=> b.count('/')
    end
  end

end
