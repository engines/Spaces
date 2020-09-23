def require_all(dir_name, file_name = '*')
  Pathname.glob(File.join("./src/#{dir_name}", '**', "#{file_name}.rb"), &method(:require))
end

def require_level(dir_name, file_name = '*')
  Pathname.glob(File.join("./src/#{dir_name}", "#{file_name}.rb"), &method(:require))
end

require_level 'spaces'
require_level 'emitting'

require_all 'blueprinting'
require_all 'resolving'
require_all 'packing'
require_all 'provisioning'
