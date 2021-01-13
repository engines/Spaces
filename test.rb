require 'pathname'
require 'addressable'

$:.unshift(Pathname.new(__FILE__).parent.join('src').expand_path)

require 'byebug'

require 'requires'

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
universe.workspace.exist? && universe.workspace.rmtree

# Create counters
init

# These don't currently work
# tenants
# domains

# Perform tests
arenas
blueprints
resolutions
packing
provisioning

# Report results
totals
