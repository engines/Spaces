# clear the universe
::Spaces::Space.universes.path.join('universe').tap do |path|
  FileUtils.rm_rf(Dir.glob(path.join('*'))) if path.exist?
end
