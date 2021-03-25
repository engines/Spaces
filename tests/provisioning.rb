module Tests

  def provisioning

    group 'CRUD provisions' do

      arena_identifier = 'development'
      blueprint_identifier = 'phpmyadmin'
      identifier = "#{arena_identifier}/#{blueprint_identifier}"

      test "create #{identifier} provisions" do
        resolution = universe.resolutions.by(identifier)
        provisions = resolution.provisioned
        output universe.provisioning.save(provisions)
      end

      test "show #{identifier} provisions" do
        output universe.provisioning.by(identifier)
      end

      test "index includes #{identifier}" do
        output identifiers = universe.provisioning.identifiers
        raise "#{identifier} not created" unless identifiers.map(&:to_s).include?(identifier)
      end

      test "index resolution_provisions for #{identifier} resolution includes #{identifier}" do
        output identifiers = universe.provisioning.identifiers
        raise "#{identifier} not shown in #{identifier}" unless identifiers.map(&:to_s).include?(identifier)
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

    group 'Create provisions for use in terraform test' do

      arena_identifier = 'development'
      identifier = 'phpmyadmin'

      identifier = "#{arena_identifier}/#{identifier}"

      test "Create #{identifier} provisions" do
        resolution = universe.resolutions.by('development/phpmyadmin')
        provisions = resolution.provisioned
        universe.provisioning.save(provisions)
      end

    end

  end
end
