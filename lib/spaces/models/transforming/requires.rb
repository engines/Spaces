require_relative 'transformable'
require_relative 'precedence'

requires 'divisions',
         'targeting'

requires 'emissions/phases'
requires 'emissions', recurse: false

requires 'adapters',
         'artifacts',
         'providers'
