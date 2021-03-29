# Index provisioning
get '/provisioning' do
  universe.provisioning.identifiers.to_json
end

# Show provisions
get '/provisioning/:arena_identifier/:blueprint_identifier' do
  universe.provisioning.by("#{params[:arena_identifier]}/#{params[:blueprint_identifier]}").to_json
end

# Create provisions
post '/provisioning' do
  resolution = universe.resolutions.by(params[:resolution_identifier])
  provisions = resolution.provisioned
  universe.provisioning.save(provisions)
  provisions.identifier.to_json
end

# Delete provisions
delete '/provisioning/:arena_identifier/:blueprint_identifier' do
  provisions = universe.provisioning.by("#{params[:arena_identifier]}/#{params[:blueprint_identifier]}")
  universe.provisioning.delete(provisions)
  nil.to_json
end

# Check if provisions exists
get '/provisioning/:arena_identifier/:blueprint_identifier/exists' do
  descriptor = Spaces::Descriptor.new(identifier: "#{params[:arena_identifier]}/#{params[:blueprint_identifier]}")
  universe.provisioning.exist?(descriptor).to_json
end

# Show payload
get '/provisioning/:arena_identifier/:blueprint_identifier/payload' do
  universe.provisioning.by("#{params[:arena_identifier]}/#{params[:blueprint_identifier]}").payload.to_json
end
