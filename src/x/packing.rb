def pack = @pack ||= Packing::Pack.new(resolution)

def commit_pack = universe.packing.commit(pack)
def export_pack = universe.packing.export(pack)
def save_pack = universe.packing.save(pack)
