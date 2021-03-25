require './api/helpers/packing'

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

# Check if pack exists
get '/packs/:arena_identifier/:blueprint_identifier/exists' do
  descriptor = Spaces::Descriptor.new(identifier: "#{params[:arena_identifier]}/#{params[:blueprint_identifier]}")
  universe.packs.exist?(descriptor).to_json
end

# Create commit
post '/packs/:arena_identifier/:blueprint_identifier/commit' do
  identifier = "#{params[:arena_identifier]}/#{params[:blueprint_identifier]}"
  pack = universe.packs.by(identifier)
  universe.packs.commit(pack)
  pack.identifier.to_json
end

# Show commit
get '/packs/:arena_identifier/:blueprint_identifier/commit' do
  output = YAML.load_file(universe.workspace.join("Universe", "PackingSpace", params[:arena_identifier], params[:blueprint_identifier], "commit", "output.yaml"))
  {
    messages: output.ui_messages.map do |ui_message|
      {
        type: ui_message.ui_message_type,
        output: ui_message.output,
      }
    end
  }
end


# # Show selection options.
# get '/packing/:identifier/selections' do
#   debugger
#   {
#     script_file_names: universe.packing.by(params[:identifier]).script_file_names,
#     script_choices_names: universe.packing.by(params[:identifier]).script_choices_names,
#   }
# end
