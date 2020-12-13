# Show validity for a resolution
get '/resolutions/:identifier/validity' do
  resolution = universe.resolutions.by(params[:identifier])
  {}.tap do |result|
    result[:errors] = {
      incomplete_divisions: resolution.incomplete_divisions,
    } if resolution.incomplete_divisions.any?
  end.to_json
end
