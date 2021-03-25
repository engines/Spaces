# Index resolutions
get '/resolutions' do
  universe.resolutions.identifiers(**query).to_json
end

# Show resolution
get '/resolutions/:arena_identifier/:blueprint_identifier' do
  universe.resolutions.by("#{params[:arena_identifier]}/#{params[:blueprint_identifier]}").to_json
# TODO: This recue is a temporary workaround. Delete me.
# rescue
  # {}.to_json
end

# Create resolution
post '/resolutions' do
  arena = universe.arenas.by(params[:arena_identifier])
  blueprint = universe.blueprints.by(params[:blueprint_identifier])
  resolution = blueprint.with_embeds.resolved_in(arena)
  universe.resolutions.save(resolution)
  resolution.identifier.to_json
end

# Update resolution
put '/resolutions/:arena_identifier/:blueprint_identifier' do
  struct = JSON.parse(request.body.read).to_struct
  resolution = Resolving::Resolution.new(struct: struct)
  universe.resolutions.save(resolution)
  resolution.identifier.to_json
end

# Delete resolution
delete '/resolutions/:arena_identifier/:blueprint_identifier' do
  resolution = universe.resolutions.by("#{params[:arena_identifier]}/#{params[:blueprint_identifier]}")
  universe.resolutions.delete(resolution)
  nil.to_json
end

# Show validity for a resolution
get '/resolutions/:arena_identifier/:blueprint_identifier/validity' do
  resolution = universe.resolutions.by("#{params[:arena_identifier]}/#{params[:blueprint_identifier]}")
  {}.tap do |result|
    result[:errors] = {
      incomplete_divisions: resolution.incomplete_divisions,
    } if resolution.incomplete_divisions.any?
  end.to_json
end
