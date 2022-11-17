require_relative 'transformable'
require_relative 'precedence'

requires 'divisions'

requires 'emissions/phases'
requires 'emissions', recurse: false

requires 'targeting'

requires 'adapters',
         'artifacts',
         'providers'
