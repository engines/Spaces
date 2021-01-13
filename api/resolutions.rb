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
  config.cache_base_path = universe.workspace.join('DefaultIconsCache')
end

# Send icon. Generate one if missing.
get '/resolutions/:identifier/icon' do
  resolution_icon_path = universe.resolutions.path.join(params[:identifier], 'icon.png')
  blueprint_icon_path = universe.blueprints.path.join(params[:identifier], 'icon')
  if resolution_icon_path.exist?
    icon_path = resolution_icon_path
  elsif blueprint_icon_path.exist?
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
    image.write resolution_icon_path
    icon_path = resolution_icon_path
  else
    icon_path = LetterAvatar.generate(params[:identifier], 50)
  end
  content_type 'image/png'
  send_file(icon_path)
end
