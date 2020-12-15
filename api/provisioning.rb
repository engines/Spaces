# Show provisions
get '/provisioning/:arena_identifier/:resolution_identifier' do
  universe.provisioning.by(
    "#{params[:arena_identifier]}/#{params[:resolution_identifier]}"
  ).to_json
rescue Errno::ENOENT
  nil.to_json
end

# Delete provisions
delete '/provisioning/:arena_identifier/:resolution_identifier' do
  provisions = universe.provisioning.by(
    "#{params[:arena_identifier]}/#{params[:resolution_identifier]}"
  )
  universe.provisioning.delete(provisions)
  nil.to_json
end
