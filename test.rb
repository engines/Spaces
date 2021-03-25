require 'pathname'
require 'addressable'
require 'byebug'

require './api/spaces'
require './tests/arenas'
require './tests/blueprinting'
require './tests/packing'
require './tests/provisioning'
require './tests/publishing'
require './tests/resolving'
require './tests/test'

extend Tests

# Clear all Spaces data
universe.workspace.exist? && universe.workspace.rmtree

# Create counters
init

# Perform tests
arenas
blueprinting
publishing
resolving
packing
provisioning

# Report results
totals
