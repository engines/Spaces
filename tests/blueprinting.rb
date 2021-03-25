module Tests

  def blueprinting

    group 'CRUD blueprints' do

      identifier = 'blueprint_for_test'

      test 'index blueprints before create' do
        output universe.blueprints.identifiers
      end

      test 'create blueprint' do
        output blueprint = Blueprinting::Blueprint.new(
          identifier: identifier,
          struct: {}.to_struct, # TODO: Remove this line. It's here as temporary fix.
        )
        output universe.blueprints.save(blueprint)
      end

      test 'index blueprints after create' do
        output identifiers = universe.blueprints.identifiers
        raise "#{identifier} not created" unless
        identifiers.map(&:to_s).include?(identifier)
      end

      test 'show blueprint' do
        output blueprint = universe.blueprints.by(identifier)
        output blueprint.to_yaml
      end

      test 'update blueprint' do
        blueprint = universe.blueprints.by(identifier)
        output blueprint.to_yaml
        struct = JSON.parse(blueprint.to_json).to_struct
        new_blueprint = Blueprinting::Blueprint.new(struct: struct)
        universe.blueprints.save(new_blueprint)
        output new_blueprint.to_yaml
      end

      test 'delete blueprint' do
        output blueprint = universe.blueprints.by(identifier)
        output universe.blueprints.delete(blueprint)
      end

      test 'index blueprints after delete' do
        output identifiers = universe.blueprints.identifiers
        raise "#{identifier} not deleted" if
        identifiers.map(&:to_s).include?(identifier)
      end

    end

  end
end
