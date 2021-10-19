require 'spaces/requiring'

include Requiring

requires 'recovery',
         'spaces',
         'engines',
         'commands',
         'controllers',
         'providers',
         only: ['requires'], recurse: false
