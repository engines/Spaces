module Tests

  def arenas

    group 'CRUD arenas' do

      identifier = 'temporary'
      repository = 'https://github.com/MarkRatjens/arena'

      test 'index arenas before create' do
        output universe.arenas.identifiers
      end

      test 'create arena' do
        output arena = Arenas::Arena.new(identifier: identifier)
        output universe.arenas.save(arena)
      end

      test 'index after create' do
        output identifiers = universe.arenas.identifiers
        raise "#{identifier} not created" unless
        identifiers.map(&:to_s).include?(identifier)
      end

      test 'show arena' do
        output arena = universe.arenas.by(identifier)
        output arena.to_yaml
      end

      test 'delete arena' do
        output arena = universe.arenas.by(identifier)
        output universe.arenas.delete(arena)
      end

      test 'index arenas after delete' do
        output identifiers = universe.arenas.identifiers
        raise "#{identifier} not deleted" if
        identifiers.map(&:to_s).include?(identifier)
      end

    end

    group 'Bootstrap arenas' do

      identifier = 'development'
      repository = 'https://github.com/MarkRatjens/arena'

      test 'create arena and apply bootstrap' do
        arena = Arenas::Arena.new(identifier: identifier)
        universe.arenas.save(arena)
        associated_arena = arena.associated
        universe.arenas.save(associated_arena)
        bootstrap_descriptor = Spaces::Descriptor.new(repository: repository)
        universe.publications.import(bootstrap_descriptor, force: true)
        bootstrap = universe.blueprints.by(bootstrap_descriptor.identifier)
        bootstrap_resolution = bootstrap.with_embeds.resolved_in(associated_arena)
        universe.resolutions.save(bootstrap_resolution)
        bootstrapped_arena = associated_arena.bootstrapped_with(bootstrap_descriptor.identifier)
        universe.arenas.save(bootstrapped_arena)
        arena_with_embeds = bootstrapped_arena.with_embeds
        universe.arenas.save(arena_with_embeds)
        resolution_identifier = "#{identifier}/#{bootstrap_descriptor.identifier}"
        resolution = universe.resolutions.by(resolution_identifier)
        provisions = resolution.provisioned
        universe.provisioning.save(provisions)
      end

      test 'show terraform files for arena' do
        arena = Arenas::Arena.new(identifier: identifier)
        output arena.artifact
      end

    end

  end
end
