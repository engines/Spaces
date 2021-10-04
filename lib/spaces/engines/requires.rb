require_level 'spaces/engines/transforming'
require_all   'spaces/engines/transforming/aspects'
require_level 'spaces/engines/transforming/divisions'
require_all   'spaces/engines/transforming/providers'
require_level 'spaces/engines/transforming/divisions/bindings'
require_all   'spaces/engines/transforming/emissions'

require_level   'spaces/engines/arenas'
require       'spaces/engines/resolving/emission' #FIX!: kludge!
require_all   'spaces/engines/packing' #FIX!: this is too early in the layers
require_all   'spaces/engines/publishing'
require_level   'spaces/engines/blueprinting'
require_all   'spaces/engines/locating'
require_all   'spaces/engines/settling'
require_all   'spaces/engines/installing'
require_all   'spaces/engines/resolving'
# require_all   'spaces/engines/packing' #FIX!: this should be here
require_all   'spaces/engines/registry'
require_all   'spaces/engines/provisioning'
require_all   'spaces/engines/keys'
require_all   'spaces/engines/universes'

require_all   'spaces/engines/adapting'
require_all   'spaces/engines/zero'
