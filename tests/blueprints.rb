module Tests

  def blueprints

    group 'CRUD blueprints' do

      identifier = 'blueprint_for_test'

      test 'index before create' do
        output universe.blueprints.identifiers
      end

      test 'create' do
        output blueprint = Blueprinting::Blueprint.new(
          identifier: identifier,
          struct: {}.to_struct, # TODO: Remove this line. It's here as temporary fix.
        )
        output universe.blueprints.save(blueprint)
      end

      test 'index after create' do
        output identifiers = universe.blueprints.identifiers
        raise "#{identifier} not created" unless
        identifiers.map(&:to_s).include?(identifier)
      end

      test 'show' do
        output blueprint = universe.blueprints.by(identifier)
        output blueprint.to_h.to_yaml
      end

      test 'delete' do
        output blueprint = universe.blueprints.by(identifier)
        output universe.blueprints.delete(blueprint)
      end

      test 'index after delete' do
        output identifiers = universe.blueprints.identifiers
        raise "#{identifier} not deleted" if
        identifiers.map(&:to_s).include?(identifier)
      end

    end

    group 'Import blueprints' do

      [
        'https://github.com/MarkRatjens/phpmyadmin/'
        # 'file:///var/tmp/git/phpmyadmin'
      ].each do |repository_url|

        descriptor = Spaces::Descriptor.new(repository: repository_url)

        identifier = descriptor.identifier

        test "import #{identifier}" do
          output universe.blueprints.by_import(descriptor)
        end

        test "index after import #{identifier}" do
          output identifiers = universe.blueprints.identifiers
          raise "blueprint not imported" unless
          identifiers.map(&:to_s).include?(identifier)
        end

        test "show after import #{identifier}" do
          output blueprint = universe.blueprints.by(identifier)
          output blueprint.to_h.to_yaml
        end

      end

    end

  end
end
