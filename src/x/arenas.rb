def arena; @arena ||= Arenas::Arena.new(descriptor: arena_descriptor) ;end

def arena_descriptor; @arena_descriptor = Spaces::Descriptor.new(identifier: 'development') ;end

def save_arena; universe.arenas.save(arena) ;end

def init_arena; universe.arenas.init(arena) ;end
def plan_arena; universe.arenas.plan(arena) ;end
def apply_arena; universe.arenas.apply(arena) ;end
