def provisions; @provisions ||= Provisioning::Provisions.new(resolution: resolution, arena: arena) ;end

def save_provisions; universe.provisioning.save(provisions) ;end
