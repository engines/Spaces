# Index provisioning
get '/provisioning' do
  universe.packs.identifiers(**query).map do |resolution_identifier|
    resolution_identifier.sub('/', '::')
  end.to_json
end

# Show provisions
get '/provisioning/:resolution_identifier' do
  universe.provisioning.by(resolution_identifier).to_json
end

# Create provisions
post '/provisioning' do
  resolution = universe.resolutions.by(resolution_identifier)
  provisions = resolution.provisioned
  universe.provisioning.save(provisions)
  provisions.identifier.to_json
end

# Delete provisions
delete '/provisioning/:resolution_identifier' do
  provisions = universe.provisioning.by(resolution_identifier)
  universe.provisioning.delete(provisions)
  nil.to_json
end

# Check if provisions exists
get '/provisioning/:resolution_identifier/exists' do
  descriptor = Spaces::Descriptor.new(identifier: resolution_identifier)
  universe.provisioning.exist?(descriptor).to_json
end

# Show artifacts
get '/provisioning/:resolution_identifier/artifact' do
  universe.provisioning.by(resolution_identifier).artifact.to_json
end
