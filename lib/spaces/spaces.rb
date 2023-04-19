require 'spaces/logging'
require 'spaces/requiring'

include Logging
include Requiring

requires 'framework',
         'models',
         'commands',
         'controllers',
         'providers'
         # only: ['requires'], recurse: false
