module Tests

  def packing

    group 'CRUD packing' do

      arena_identifier = 'development'
      blueprint_identifier = 'phpmyadmin'
      resolution_identifier = "#{arena_identifier}::#{blueprint_identifier}"

      test "create #{resolution_identifier} pack" do
        resolution = universe.resolutions.by(resolution_identifier)
        puts resolution.to_yaml
        pack = resolution.packed
        universe.packs.save(pack)
      end

      test "show #{resolution_identifier} pack" do
        output pack = universe.packs.by(resolution_identifier)
        output universe.packs.save(pack).to_s
      end

      test "index includes #{resolution_identifier}" do
        output identifiers = universe.packs.identifiers
        raise "#{resolution_identifier} not created" unless
        identifiers.map(&:to_s).include?(resolution_identifier)
      end

      test 'delete' do
        output pack = universe.packs.by(resolution_identifier)
        output universe.packs.delete(pack)
      end

      test 'index after delete' do
        output identifiers = universe.packs.identifiers
        raise "#{resolution_identifier} not deleted" if
        identifiers.map(&:to_s).include?(resolution_identifier)
      end

    end

    group 'Create pack for use in terraform test' do

      arena_identifier = 'development'
      blueprint_identifier = 'phpmyadmin'
      resolution_identifier = "#{arena_identifier}::#{blueprint_identifier}"

      test "Create #{resolution_identifier} pack" do
        resolution = universe.resolutions.by(resolution_identifier)
        pack = resolution.packed
        universe.packs.save(pack)
        pack = universe.packs.by(resolution_identifier)
        # universe.packs.commit(pack)
        # build = YAML.load_file(universe.workspace.join("Universe", "PackingSpace", resolution_identifier, "commit", "output.yaml"))
        # output build.stdout
      end

    end

  end
end
