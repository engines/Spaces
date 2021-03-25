# Show blueprint readme.
get '/blueprints/:identifier/readme' do
  readme_path = universe.blueprints.path.join(params[:identifier], 'README.md')
  content_type 'text/markdown'
  if readme_path.exist?
    readme_path.read
  else
    ''
  end
end

# Update blueprint readme.
put '/blueprints/:identifier/readme' do
  readme_path = universe.blueprints.path.join(params[:identifier], 'README.md')
  readme_text = params[:readme]
  readme_path.write(readme_text)
  nil.to_json
end
