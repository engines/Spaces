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
a common starting point is to start with a descriptor to locate a source project. For example:

```
require_relative 'ruby/spaces/descriptor'
descriptor = Spaces::Descriptor.new.tap do |m|
  m.repository = 'https://github.com/MarkRatjens/publify.git'
end
```

which can be used to import a project from an external Git repo.

There are optional attributes you can declare for a project:

```
descriptor = Spaces::Descriptor.new.tap do |m|
  m.repository = 'https://github.com/MarkRatjens/publify.git'
  m.branch = 'current'
end
```

# Projects
## Importing

You can import a project into your universe with:

```
project_space = universe.blueprints
project_space.import(descriptor)
```

## Retrieving an imported project

Once you've imported a project, you can retrieve it with:

```
project_space.by(descriptor)
```

## Generating an Installations::Installation

A `Installations::Installation` is what will generate a DockerFile. You create an installation from a project like so:

```
project = universe.blueprints.by(descriptor)
installation = project.installation
```

## Saving an Installations::Installation

Save `Installations::Installation` to installation space with:

```
installation_space = universe.installations
installation_space.save(installation)
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

## Client

To run the GUI:
1. `bundle`
2. `npm i`
3. `thin start`

## Terms of use

Copyright (C) 2020 P3 Nominees Pty Ltd

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program (see the LICENSE.md file in the root of the repository). If not, see <https://www.gnu.org/licenses/>.
