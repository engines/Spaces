# Index packs
get '/packs' do
  universe.packs.identifiers.to_json
end

# Show pack
get '/packs/:arena_identifier/:blueprint_identifier' do
  universe.packs.by("#{params[:arena_identifier]}/#{params[:blueprint_identifier]}").to_json
end

# Delete pack
delete '/packs/:arena_identifier/:blueprint_identifier' do
  pack = universe.packs.by("#{params[:arena_identifier]}/#{params[:blueprint_identifier]}")
  universe.packs.delete(pack)
  nil.to_json
end

# Create pack
post '/packs' do
  pack = universe.resolutions.by("#{params[:resolution_identifier]}").packed
  universe.packs.save(pack)
  pack.identifier.to_json
end

# Show payload
get '/packs/:arena_identifier/:blueprint_identifier/payload' do
  universe.packs.by("#{params[:arena_identifier]}/#{params[:blueprint_identifier]}").payload.to_json
end
