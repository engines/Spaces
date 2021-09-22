# Monkey patch terraform gem
#
# Add `config` arguments to gem class methods for command configuation
#
# Spaces can then pass in configuation for stdout, etc.
require 'ruby_terraform'
require 'gems/ruby_terraform/class_methods'
