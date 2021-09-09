# Monkey patch git gem
#
# Add better support for streaming output
# - add &block as arguments on clone, pull, push
#   - &block is a procedure that has output yielded to it
#   - &block is passed to git command to capture output from IO
# - add --verbose and --progress options to yield more output
require 'git'
require 'gems/git/git/base'
require 'gems/git/git/branch'
require 'gems/git/git/lib'
