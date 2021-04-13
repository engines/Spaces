module Tests

  def provisioning

    group 'CRUD arena provisions' do

      resolution_identifier = 'phpmyadmin'
      arena_identifier = 'test'

      identifier = "#{arena_identifier.with_identifier_separator}#{resolution_identifier}"
      arena = Arenas::Arena.new(identifier: arena_identifier)
      universe.arenas.save(arena)
      resolution = universe.resolutions.by(resolution_identifier)

      test "create #{identifier} provisions" do
        output provisions = Provisioning::Provisions.new(
          resolution: resolution,
          arena: arena
        )
        output universe.provisioning.save(provisions)
      end

      test "show #{identifier} provisions" do
        output universe.provisioning.by(identifier)
      end

      test "index includes #{identifier}" do
        output identifiers = universe.provisioning.identifiers
        raise "#{identifier} not created" unless identifiers.map(&:to_s).include?(identifier)
      end

      test "index resolution_provisions for #{resolution_identifier} resolution includes #{identifier}" do
        output identifiers = universe.provisioning.identifiers(resolution_identifier: resolution_identifier)
        raise "#{identifier} not shown in #{resolution_identifier}" unless identifiers.map(&:to_s).include?(identifier)
      end

      test "index arena_provisions for #{arena_identifier} arena includes #{identifier}" do
        output identifiers = universe.provisioning.identifiers(arena_identifier: arena_identifier)
        raise "#{identifier} not shown in #{arena_identifier}" unless identifiers.map(&:to_s).include?(identifier)
      end

      test 'delete' do
        output provisions = universe.provisioning.by(identifier)
        output universe.provisioning.delete(provisions)
      end

      test 'index after delete' do
        output identifiers = universe.provisioning.identifiers
        raise "#{identifier} not deleted" if
        identifiers.include?(identifier)
      end

    end

  end
end
