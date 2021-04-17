module Tests

  def resolving

    group 'CRUD resolutions' do

      arena_identifier = 'development'
      blueprint_identifier = 'phpmyadmin'
      identifier = "#{arena_identifier}::#{blueprint_identifier}"

      test "create #{identifier} resolution" do
        output blueprint = universe.blueprints.by(blueprint_identifier)
        output arena = universe.arenas.by(arena_identifier)
        output resolution = blueprint.with_embeds.resolved_in(arena)
        output universe.resolutions.save(resolution)
      end

      test "show #{identifier} resolution" do
        output universe.resolutions.by(identifier).to_s
      end

      test "index includes #{identifier}" do
        output identifiers = universe.resolutions.identifiers
        raise "#{identifier} not created" unless
        identifiers.map(&:to_s).include?(identifier)
      end

      test 'update resolution' do
        resolution = universe.resolutions.by(identifier)
        output resolution.to_yaml
        struct = JSON.parse(resolution.to_json).to_struct
        new_resolution = Resolving::Resolution.new(struct: struct)
        universe.resolutions.save(new_resolution)
        output new_resolution.to_yaml
      end

      test 'delete' do
        output resolution = universe.resolutions.by(identifier)
        output universe.resolutions.delete(resolution)
      end

      test 'index after delete' do
        output identifiers = universe.resolutions.identifiers
        raise "#{identifier} not deleted" if
        identifiers.map(&:to_s).include?(identifier)
      end

    end

    group 'Create resolution for use in packing and provisioning tests' do

      arena_identifier = 'development'
      blueprint_identifier = 'phpmyadmin'
      identifier = "#{arena_identifier}/#{blueprint_identifier}"

      test "create #{identifier} resolution" do
        output blueprint = universe.blueprints.by(blueprint_identifier)
        output arena = universe.arenas.by(arena_identifier)
        output resolution = blueprint.with_embeds.resolved_in(arena)
        output universe.resolutions.save(resolution)
      end
    end

  end
end
