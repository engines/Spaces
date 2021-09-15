require_level 'spaces/engines/transforming'
require_level 'spaces/engines/transforming/divisions'
require_level 'spaces/engines/transforming/divisions/bindings'
require_all   'spaces/engines/transforming/emissions'

require_all   'spaces/engines/arenas'
require       'spaces/engines/resolving/emission' #FIX!: kludge!
require_all   'spaces/engines/packing' #FIX!: this is too early in the layers
require_all   'spaces/engines/publishing'
require_all   'spaces/engines/blueprinting'
require_all   'spaces/engines/locating'
require_all   'spaces/engines/settling'
require_all   'spaces/engines/installing'
require_all   'spaces/engines/resolving'
# require_all   'spaces/engines/packing' #FIX!: this should be here
require_all   'spaces/engines/registry'
require_all   'spaces/engines/provisioning'
require_all   'spaces/engines/keys'
require_all   'spaces/engines/universes'

# TODO: Reinstate require _all for outputting
# require_all   'spaces/engines/outputting'
require   'spaces/engines/outputting/space'
require   'spaces/engines/outputting/output'
require   'spaces/engines/outputting/output/build'
require   'spaces/engines/outputting/output/execution'
require   'spaces/engines/outputting/output/export'
require   'spaces/engines/outputting/output/import'
require_all   'spaces/engines/provider_aspects'
