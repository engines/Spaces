def resolution_mesh_for(arena)

  nodes = [{
    id: 'system',
    name: 'system',
    label: 'system'
  }]
  edges = []

  provisions_identifiers = universe.provisioning.identifiers(arena)
  provisions_identifiers.each do |identifier|
    provisions = universe.provisioning.by(identifier)
    resolution = universe.resolutions.by(provisions.resolution_identifier)
    nodes.push({
      id: "applications/#{resolution.identifier}",
      name: "applications/#{resolution.identifier}",
      label: resolution.identifier
    })
    edges.push({
      source: 'system',
      target: "applications/#{resolution.identifier}"
    })
    resolution.binding_descriptors.each do |binding|
      edges.push({
        source: "applications/#{resolution.identifier}",
        target: "applications/#{binding.identifier}"
      })
    end
  end

  {
    nodes: nodes,
    edges: edges
  }

end

def resolution_tree_for(arena)

  nodes = [{
    id: 'system',
    name: 'system',
    label: 'system'
  }]

  provisions_identifiers = universe.provisioning.identifiers(arena)
  provisions_identifiers.each do |identifier|
    provisions = universe.provisioning.by(identifier)
    resolution = universe.resolutions.by(provisions.resolution_identifier)
    nodes.push({
      id: "applications/#{resolution.identifier}",
      name: "applications/#{resolution.identifier}",
      label: resolution.identifier,
      parent: 'system'
    })
    resolution.binding_descriptors.each do |binding|
      nodes.push({
        id: "applications/#{resolution.identifier}/#{binding.identifier}",
        name: "applications/#{binding.identifier}",
        label: binding.identifier,
        parent: "applications/#{resolution.identifier}"
      })
      nodes.push({
        id: "applications/#{binding.identifier}/#{resolution.identifier}",
        name: "applications/#{resolution.identifier}",
        label: resolution.identifier,
        parent: "applications/#{binding.identifier}"
      })
    end
  end

  nodes

end
