# Show provisioning for a resolution.
get '/resolutions/:identifier/provisioning' do
  universe.provisioning.provisioning_for(
    resolution_identifier: params[:identifier]
  ).to_json
end

# Show validity for a resolution
get '/resolutions/:identifier/validity' do
  resolution = universe.resolutions.by(params[:identifier])
  {}.tap do |result|
    result[:errors] = {
      incomplete_divisions: resolution.incomplete_divisions,
    } if resolution.incomplete_divisions.any?
  end.to_json
end

LetterAvatar.setup do |config|
  config.colors_palette = :iwanthue
  config.pointsize = 400
end

# Send icon. Generate one if missing.
get '/resolutions/:identifier/icon' do
  blueprint_icon_path = Fs.workspace.join('Universe', 'BlueprintingSpace', params[:identifier], 'icon')
  if blueprint_icon_path.exist?
    image = MiniMagick::Image.open(blueprint_icon_path)
    image.format 'png'
    image.combine_options do |options|
      options.thumbnail '48x48>'
      options.gravity 'center'
      options.extent '50x50'
      options.background 'white'
      options.bordercolor '#999'
      options.border 2
    end
    resolution_icon_path = Fs.workspace.join('Universe', 'ResolvingSpace', params[:identifier], 'icon.png')
    image.write resolution_icon_path
  else
    resolution_icon_path = LetterAvatar.generate(params[:identifier], 50)
  end
  content_type 'image/png'
  send_file(resolution_icon_path)
end
