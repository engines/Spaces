Spaces
======

# Getting Started

You'll need to create a directory for Spaces to write all its data at:

* \opt\UniversalSpace

Ideally, Spaces should create this directory on first access, but I ran into permission problems and moved on.

James: perhaps you could advise how I programmatically create a new directory under /opt?

# The Universe

Spaces exist in a universe which you can create with the `Universal::Space` class:

  ```
  require_relative 'universal/space'
  universe = Universal::Space.new
  ```
