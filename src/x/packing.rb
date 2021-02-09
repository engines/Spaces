def pack; @pack ||= resolution.packed ;end

def commit_pack; universe.packs.commit(pack) ;end
def export_pack; universe.packs.export(pack) ;end
def save_pack; universe.packs.save(pack) ;end
