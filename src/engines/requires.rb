def require_all(dir_name, file_name = '*')
  Pathname.glob(File.join("./src/#{dir_name}", '**', "#{file_name}.rb"), &method(:require))
end

def require_level(dir_name, file_name = '*')
  Pathname.glob(File.join("./src/#{dir_name}", "#{file_name}.rb"), &method(:require))
end

require_level 'engines/emitting'

require_all 'engines/arenas'
require_all 'engines/blueprinting'
require_all 'engines/resolving'
require_all 'engines/packing'
require_all 'engines/provisioning'
