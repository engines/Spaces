module Tests

  def packing

    group 'CRUD packing' do

      arena_identifier = 'development'
      blueprint_identifier = 'phpmyadmin'
      identifier = "#{arena_identifier}/#{blueprint_identifier}"

      test "create #{identifier} pack" do
        resolution = universe.resolutions.by(identifier)
        puts resolution.to_yaml
        pack = resolution.packed
        universe.packs.save(pack)
      end

      test "show #{identifier} pack" do
        output pack = universe.packs.by(identifier)
        output universe.packs.save(pack).to_s
      end

      test "index includes #{identifier}" do
        output identifiers = universe.packs.identifiers
        raise "#{identifier} not created" unless
        identifiers.map(&:to_s).include?(identifier)
      end

      test 'delete' do
        output pack = universe.packs.by(identifier)
        output universe.packs.delete(pack)
      end

      test 'index after delete' do
        output identifiers = universe.packs.identifiers
        raise "#{identifier} not deleted" if
        identifiers.map(&:to_s).include?(identifier)
      end

    end

    group 'Create pack for use in terraform test' do

      arena_identifier = 'development'
      blueprint_identifier = 'phpmyadmin'
      identifier = "#{arena_identifier}/#{blueprint_identifier}"

      test "Create #{identifier} pack" do
        resolution = universe.resolutions.by(identifier)
        pack = resolution.packed
        universe.packs.save(pack)
        pack = universe.packs.by(identifier)
        # universe.packs.commit(pack)
        # build = YAML.load_file(universe.workspace.join("Universe", "PackingSpace", identifier, "commit", "output.yaml"))
        # output build.stdout
      end

    end

  end
end
