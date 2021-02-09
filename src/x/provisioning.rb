def provisions; @provisions ||= resolution.provisioned ;end

def save_provisions; universe.provisioning.save(provisions) ;end
