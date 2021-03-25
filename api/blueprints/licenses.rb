# Show blueprint license.
get '/blueprints/:identifier/license' do
  license_path = universe.blueprints.path.join(params[:identifier], 'LICENSE.md')
  content_type 'text/markdown'
  if license_path.exist?
    license_path.read
  else
    ''
  end
end

# Update blueprint license.
put '/blueprints/:identifier/license' do
  license_path = universe.blueprints.path.join(params[:identifier], 'LICENSE.md')
  license_text = params[:license]
  license_path.write(license_text)
  nil.to_json
end
