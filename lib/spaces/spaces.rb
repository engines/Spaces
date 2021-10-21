require 'spaces/requiring'

include Requiring

requires 'framework',
         'engines',
         'commands',
         'controllers',
         'providers',
         only: ['requires'], recurse: false
