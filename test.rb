require 'byebug'
require 'fileutils'

require './api/universe'
require './tests/arenas'
require './tests/blueprints'
require './tests/domains'
require './tests/packing'
require './tests/provisioning'
require './tests/resolutions'
require './tests/tenants'
require './tests/test'

extend Tests

# Clear all Spaces data
FileUtils.rm_rf(Dir.glob('/opt/spaces/Universe/*'))

# Create counters
init

# Perform tests
tenants
arenas
domains
blueprints
resolutions
packing
provisioning

# Report results
totals
