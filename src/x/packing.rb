require_relative '../packing/pack'

def pack; @pack ||= Packing::Pack.new(resolution) ;end

def commit_pack; universe.packing.commit(pack) ;end
def export_pack; universe.packing.export(pack) ;end
def save_pack; universe.packing.save(pack) ;end
