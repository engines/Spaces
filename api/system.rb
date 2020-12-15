require './api/helpers/system'

# Show system settings
get '/system' do
  system_settings.to_json
end

# Update system settings
# TODO: persist the data
post '/system' do
  p 'POST System Settings'
  p JSON.parse(request.body.read)
  system_settings.to_json
end

# Show blueprinting settings
get '/system/blueprinting' do
  blueprinting_settings.to_json
end
