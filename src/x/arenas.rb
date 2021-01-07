def arena = @arena ||= Arenas::Arena.new(identifier: 'development')

def save_arena = universe.arenas.save(arena)

def init_arena = universe.arenas.init(arena)
def plan_arena = universe.arenas.plan(arena)
def apply_arena = universe.arenas.apply(arena)
