def provisions = @provisions ||= Provisioning::Provisions.new(resolution: resolution, arena: arena)

def save_provisions = universe.provisioning.save(provisions)
