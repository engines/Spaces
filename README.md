Spaces
======

# Getting Started

You'll need to create a directory for Spaces to write all its data at:

* `\opt\UniversalSpace`

Ideally, Spaces should create this directory on first access, but I ran into permission problems and moved on.

James: perhaps you could advise how I programmatically create a new directory under /opt?

# The Universe

Spaces exist in a universe which you can create with the `Universal::Space` class:

```
require_relative 'ruby/universal/space'
universe = Universal::Space.new
```

From a universe you can access a variety of spaces. For example:

```
universe.blueprints
universe.containers
```

# Spaces::Descriptor

A `Spaces::Descriptor` object is the way spaces objects are saved and located in their various spaces. While Spaces generates its own descriptors internally,
a common starting point is to start with a descriptor to locate a source blueprint. For example:

```
require_relative 'ruby/spaces/descriptor'
descriptor = Spaces::Descriptor.new.tap do |m|
  m.value = 'https://github.com/MarkRatjens/publify.git'
end
```

which can be used to import a blueprint from an external Git repo.

There are optional attributes you can declare for a blueprint:

```
descriptor = Spaces::Descriptor.new.tap do |m|
  m.value = 'https://github.com/MarkRatjens/publify.git'
  m.branch = 'current'
end
```

# Blueprints
## Importing

You can import a blueprint into your universe with:

```
blueprint_space = universe.blueprints
blueprint_space.import(descriptor)
```

## Retrieving an imported blueprint

Once you've imported a blueprint, you can retrieve it with:

```
blueprint_space.by(descriptor)
```

# Containers
## Generating a Container::Tensor

A `Container::Tensor` is what will generate a DockerFile. You create a tensor from a blueprint like so:

```
blueprint = universe.blueprints.by(descriptor)
tensor = blueprint.tensor
```

## Saving a Container::Tensor

Save `Container::Tensor` to container space with:

```
container_space = universe.containers
container_space.save_yaml(tensor)
```

## Generating DockerFile content

A tensor can generate docker file content:

```
content = tensor.docker_file
```

## Saving docker file content to a file

Save docker file content to container space with:

```
container_space.save(content)
```
