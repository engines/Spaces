module Tests

  def provisioning

    group 'CRUD arena provisions' do

      resolution_identifier = 'phpmyadmin'
      arena_identifier = 'test'

      identifier = "#{arena_identifier}/#{resolution_identifier}"
      arena = Arenas::Arena.new(identifier: arena_identifier)
      universe.arenas.save(arena)
      resolution = universe.resolutions.by(resolution_identifier)

      test "create #{identifier} provisions" do
        output provisions = Provisioning::Provisions.new(resolution: resolution, arena: arena)
        output universe.provisioning.save(provisions)
      end

      test "show #{identifier} provisions" do
        output universe.provisioning.by(identifier)
      end

      test "index includes #{identifier}" do
        output identifiers = universe.provisioning.identifiers
        raise "#{identifier} not created" unless
        identifiers.map(&:to_s).include?(identifier)
      end

      test 'delete' do
        output provisions = universe.provisioning.by(identifier)
        output universe.provisioning.delete(provisions)
      end

      test 'index after delete' do
        output identifiers = universe.provisioning.identifiers
        raise "#{identifier} not deleted" if
        identifiers.map(&:to_s).include?(identifier)
      end

    end

  end
end
