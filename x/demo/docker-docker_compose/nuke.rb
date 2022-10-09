# clear the universe
::Spaces::Space.universes.path.join('universe').tap do |path|
  FileUtils.rm_rf(Dir.glob(path.join('*'))) if path.exist?
end

# clear Docker (except for base images; they're slow to download)
::Docker::Container.all(all: true).each do |container|
  container.delete(:force => true)
end
::Docker::Image.all.each do |image|
  tags = image.info['RepoTags']
  next if tags.include?("debian:latest")
  image.remove(:force => true)
end
