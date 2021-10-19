requires 'docker/adapters',
         'docker/artifacts',
         'docker/patch'
requires 'docker', recurse: false

requires 'packer/adapters',
         'packer/artifacts',
         'packer/providers'
requires 'packer', recurse: false

requires 'terraform/adapters',
         'terraform/artifacts',
         'terraform/providers'
requires 'terraform', recurse: false
