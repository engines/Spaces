Spaces
======

# Getting Started

You'll need to create a directory for Spaces to write all its data at:

* `$ENGINES_WORKSPACE/spaces`

If the `ENGINES_WORKSPACE` isn't set it'll default to `$TMP` and finally `/tmp`. We
recommended you set `ENGINES_WORKSPACE`.

# The Universe

Spaces exist in a universe which you can create with the `Universe` class:

```
require_relative 'src/universe'
universe = Universe.new
```

From a universe you can access a variety of spaces. For example:

```
universe.blueprints
universe.resolutions
```

# Spaces::Descriptor

A `Spaces::Descriptor` object is the way spaces objects are saved and located in their various spaces. While Spaces generates its own descriptors internally,
a common starting point is to start with a descriptor to locate a source blueprint. For example:

```
require_relative 'src/spaces/models/descriptor'
descriptor = Spaces::Descriptor.new(
  repository: 'https://github.com/v2Blueprints/publify.git'
)
```

which can be used to import a blueprint from an external Git repo.

There are optional attributes you can declare for a blueprint:

```
descriptor = Spaces::Descriptor.new(
  repository: 'https://github.com/v2Blueprints/publify.git',
  branch: 'current'
)
```

# Blueprinting
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

## Generating a Resolving::Resolution

A `Resolving::Resolution` is what will generate a DockerFile. You create a Resolution from a blueprint like so:

```
resolution = universe.resolutions.by(descriptor)
```

## Saving a Resolving::Resolution

Save `Resolving::Resolution` to resolution space with:

```
universe.resolutions.save(resolution)
```

## Example
```
require './src/x/mariadb'
import
r = universe.resolutions.by('mariadb')
save_pack
save_arena
save_provisions
```

# Containers

# GUI API

Run `bundle` before starting API or running tests.

## Run API

To run the API: `ruby api.rb`

## Test API

To run tests: `ruby test.rb`


# Terms

Copyright (C) 2020 P3 Nominees Pty Ltd

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program (see the LICENSE.md file in the root of the repository). If not, see <https://www.gnu.org/licenses/>.
