def require_all(dir_name, file_name = '*')
  Pathname.glob(Pathname.new("./src/#{dir_name}").join('**', "#{file_name}.rb"), &method(:require))
end

def require_level(dir_name, file_name = '*')
  Pathname.glob(Pathname.new("./src/#{dir_name}").join("#{file_name}.rb"), &method(:require))
end

require_level 'engines/emissions'

require_all 'engines/arenas'
require_all 'engines/packing'
require_all 'engines/blueprinting'
require_all 'engines/resolving'
require_all 'engines/provisioning'
