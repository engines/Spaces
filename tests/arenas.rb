module Tests

  def arenas

    group 'CRUD arenas' do

      identifier = 'arena_for_test'

      test 'index before create' do
        output universe.arenas.identifiers
      end

      test 'create' do
        output arena = Arenas::Arena.new(identifier: identifier)
        output universe.arenas.save(arena)
      end

      test 'index after create' do
        output identifiers = universe.arenas.identifiers
        raise "#{identifier} not created" unless
        identifiers.map(&:to_s).include?(identifier)
      end

      test 'show' do
        output arena = universe.arenas.by(identifier)
        output arena.to_h.to_yaml
      end

      test 'delete' do
        output arena = universe.arenas.by(identifier)
        output universe.arenas.delete(arena)
      end

      test 'index after delete' do
        output identifiers = universe.arenas.identifiers
        raise "#{identifier} not deleted" if
        identifiers.map(&:to_s).include?(identifier)
      end

    end

  end
end
