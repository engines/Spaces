# Index packs
get '/packs' do
  universe.packs.identifiers(**query).map do |resolution_identifier|
    resolution_identifier.sub('/', '::')
  end.to_json
end

# Show pack
get '/packs/:resolution_identifier' do
  universe.packs.by(resolution_identifier).to_json
end

# Delete pack
delete '/packs/:resolution_identifier' do
  pack = universe.packs.by(resolution_identifier)
  universe.packs.delete(pack)
  nil.to_json
end

# Create pack
post '/packs' do
  pack = universe.resolutions.by(resolution_identifier).packed
  universe.packs.save(pack)
  pack.identifier.to_json
end

# Show artifacts
get '/packs/:resolution_identifier/artifact' do
  universe.packs.by(resolution_identifier).artifact.to_json
end
