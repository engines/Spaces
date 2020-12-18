require 'byebug'

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
Pathname.new("/opt/spaces/Universe").children.each(&:rmtree)

# Create counters
init

# Perform tests
# tenants
arenas
# domains
blueprints
resolutions
packing
provisioning

# Report results
totals
