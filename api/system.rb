# Show system settings
# TODO: Use real data!
get '/system' do
  {
    label: {
      text: 'My server!',
      color: 'white',
      background_color: 'blue',
    }
  }.to_json
end

# Update system settings
# TODO: persist the data
post '/system' do
  p 'POST System Settings'
  p JSON.parse(request.body.read)
  system_settings.to_json
end
