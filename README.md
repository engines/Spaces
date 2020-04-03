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
  m.repository = 'https://github.com/MarkRatjens/publify.git'
end
```

which can be used to import a blueprint from an external Git repo.

There are optional attributes you can declare for a blueprint:

```
descriptor = Spaces::Descriptor.new.tap do |m|
  m.repository = 'https://github.com/MarkRatjens/publify.git'
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

## Generating an Installations::Installation

A `Installations::Installation` is what will generate a DockerFile. You create an installation from a blueprint like so:

```
blueprint = universe.blueprints.by(descriptor)
installation = blueprint.installation
```

## Saving an Installations::Installation

Save `Installations::Installation` to blueprint space with:

```
blueprint_space = universe.blueprints
blueprint_space.save_yaml(installation)
```

# Containers

## Generating DockerFile content

A installation can generate docker file content:

```
content = installation.docker_file
```

## Saving docker file content to a file

Save docker file content to container space with:

```
container_space.save(content)
```

# Image Subjects
## Generating an Images::Subject

An `Images::Subject` is what will manage a folder structure that you'll eventually be able to use as an image to build a container. Generate an
image subject from an installation in a similar way to generating a docker file:

```
content = installation.image_subject
```

## Saving image file content to image space

Save the image subject's folders and files to image space with:

```
image_space = universe.images
image_space.save(content)
```
