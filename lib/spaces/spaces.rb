require 'spaces/requiring'

include Requiring

requires 'framework',
         'models',
         'commands',
         'controllers',
         'providers',
         only: ['requires'], recurse: false
