require 'forwardable'
require 'yaml'
require 'json'
require 'duplicate'
require 'pathname'
require 'i18n'
require 'engines-logger'

require 'spaces/requiring'
include Requiring

require_all 'spaces/recovery'
require_level 'spaces/spaces'
require_level 'spaces/commands'
require_level 'spaces/controllers'
require_level 'spaces/engines'

require_all 'spaces/providers'

require 'spaces/universe'
