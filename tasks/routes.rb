task :routes do

  require './web/app'

  App::Api::routes.each do |verb,routes|
    routes.each do |route|
      puts "#{verb} #{route[0]}"
    end
  end

end
