module Tests

  def provisioning

    group 'CRUD provisions' do

      blueprint_identifier = 'phpmyadmin'
      arena_identifier = 'development'
      resolution_identifier = "#{arena_identifier}::#{blueprint_identifier}"

      arena = Arenas::Arena.new(identifier: arena_identifier)
      universe.arenas.save(arena)
      resolution = universe.resolutions.by(resolution_identifier)

      test "create #{resolution_identifier} provisions" do
        resolution = universe.resolutions.by(resolution_identifier)
        provisions = resolution.provisioned
        output universe.provisioning.save(provisions)
      end

      test "show #{resolution_identifier} provisions" do
        output universe.provisioning.by(resolution_identifier)
      end

      test "index includes #{resolution_identifier}" do
        output identifiers = universe.provisioning.identifiers
        raise "#{resolution_identifier} not created" unless identifiers.map(&:to_s).include?(resolution_identifier)
      end

      test "index resolution_provisions for #{resolution_identifier} resolution includes #{resolution_identifier}" do
        output identifiers = universe.provisioning.identifiers
        raise "#{resolution_identifier} not shown in #{resolution_identifier}" unless identifiers.map(&:to_s).include?(resolution_identifier)
      end

      test "index arena_provisions for #{arena_identifier} arena includes #{resolution_identifier}" do
        output identifiers = universe.provisioning.identifiers(arena_identifier: arena_identifier)
        raise "#{resolution_identifier} not shown in #{arena_identifier}" unless identifiers.map(&:to_s).include?(resolution_identifier)
      end

      test 'delete' do
        output provisions = universe.provisioning.by(resolution_identifier)
        output universe.provisioning.delete(provisions)
      end

      test 'index after delete' do
        output identifiers = universe.provisioning.identifiers
        raise "#{resolution_identifier} not deleted" if
        identifiers.include?(resolution_identifier)
      end

    end

    group 'Create provisions for use in terraform test' do

      blueprint_identifier = 'phpmyadmin'
      arena_identifier = 'development'
      resolution_identifier = "#{arena_identifier}::#{blueprint_identifier}"

      test "Create #{resolution_identifier} provisions" do
        resolution = universe.resolutions.by(resolution_identifier)
        provisions = resolution.provisioned
        universe.provisioning.save(provisions)
      end

    end

  end
end
