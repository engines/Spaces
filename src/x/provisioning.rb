require_relative '../provisioning/provisions'

def provisions; @provisions ||= Provisioning::Provisions.new(provisions_descriptor) ;end

def provisions_descriptor; @provisions_descriptor = Spaces::Descriptor.new(identifier: 'development') ;end

def init_provisions; universe.provisioning.init(provisions) ;end
def plan_provisions; universe.provisioning.plan(provisions) ;end
def apply_provisions; universe.provisioning.apply(provisions) ;end
def save_provisions; universe.provisioning.save(provisions) ;end
