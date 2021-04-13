# Index resolutions
get '/resolutions' do
  universe.resolutions.identifiers(**query).map do |resolution_identifier|
    resolution_identifier.sub('/', '::')
  end.to_json
end

# Show resolution
get '/resolutions/:resolution_identifier' do
  universe.resolutions.by(resolution_identifier).to_json
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
put '/resolutions/:resolution_identifier' do
  struct = JSON.parse(request.body.read).to_struct
  resolution = Resolving::Resolution.new(struct: struct)
  universe.resolutions.save(resolution)
  resolution.identifier.to_json
end

# Delete resolution
delete '/resolutions/:resolution_identifier' do
  resolution = universe.resolutions.by(resolution_identifier)
  universe.resolutions.delete(resolution)
  nil.to_json
end

# Show validity for a resolution
get '/resolutions/:resolution_identifier/validity' do
  resolution = universe.resolutions.by(resolution_identifier)
  {}.tap do |result|
    result[:errors] = {
      incomplete_divisions: resolution.incomplete_divisions,
    } if resolution.incomplete_divisions.any?
  end.to_json
end

# Show packing and provisioning status for a resolution
get '/resolutions/:resolution_identifier/status' do
  descriptor = Spaces::Descriptor.new(identifier: resolution_identifier)
  resolution = universe.resolutions.by(resolution_identifier)
  {
    pack: {
      exist: universe.packs.exist?(descriptor),
      allowed: resolution.packable?
    },
    provisions: {
      exist: universe.provisioning.exist?(descriptor),
      allowed: resolution.provisionable?
    }
  }.to_json
end

# Show a resolution and its binding target resolutions.
# This route is used by GUI to generate a topology graph for a resolution.
get '/resolutions/:resolution_identifier/graph' do
  universe.resolutions.by(resolution_identifier).graphed.to_json
end
