task :routes do

  require './web/app'

  # puts App::Api::routes.to_yaml

  App::Api::routes.each do |verb,routes|
    routes.each do |route|
      puts "#{verb} #{route[0].to_s}"
    end
  end

end
