require 'byebug'
require 'fileutils'

require_relative 'src/universe'

@total = 0
@fails = 0
@n1 = 0

def test_group(name)
  @n2 = 0
  puts "#{@n1 += 1}. #{name}\n\n"
  yield
end

def test(name)
  puts "#{@n1}.#{@n2 += 1} #{name}"
  @total += 1
  yield
  puts "\e[32mOK\e[0m"
rescue => e
  @fails += 1
  puts "\e[31mERROR\e[0m\n#{e.full_message}"
ensure
  puts "\n"
end

FileUtils.rm_rf(Dir.glob('/opt/spaces/Universe/*'))

sleep 2

universe = Universe.new

test_group 'CRUD arenas' do

  identifier = 'arena_for_test'

  test 'index before create' do
    p universe.arenas.identifiers
  end

  test 'create' do
    p arena = Arenas::Arena.new(identifier: identifier)
    p universe.arenas.save(arena)
  end

  test 'index after create' do
    p identifiers = universe.arenas.identifiers
    raise "#{identifier} not created" unless
    identifiers.map(&:to_s).include?(identifier)
  end

  test 'show' do
    p arena = universe.arenas.by(identifier)
    puts arena.to_h.to_yaml
  end

  test 'delete' do
    p arena = universe.arenas.by(identifier)
    p universe.arenas.delete(arena)
  end

  test 'index after delete' do
    p identifiers = universe.arenas.identifiers
    raise "#{identifier} not deleted" if
    identifiers.map(&:to_s).include?(identifier)
  end

end

test_group 'CRUD tenants' do

  identifier = 'tenant_for_test'

  test 'index before create' do
    p universe.tenants.identifiers
  end

  test 'create' do
    p tenant = Associations::Tenant.new(identifier: identifier)
    p universe.tenants.save(tenant)
  end

  test 'index after create' do
    p identifiers = universe.tenants.identifiers
    raise "#{identifier} not created" unless
    identifiers.map(&:to_s).include?(identifier)
  end

  test 'show' do
    p tenant = universe.tenants.by(identifier)
    puts tenant.to_h.to_yaml
  end

  test 'delete' do
    p tenant = universe.tenants.by(identifier)
    p universe.tenants.delete(tenant)
  end

  test 'index after delete' do
    p identifiers = universe.tenants.identifiers
    raise "#{identifier} not deleted" if
    identifiers.map(&:to_s).include?(identifier)
  end

end

test_group 'CRUD domains' do

  identifier = 'domain.for.test'

  test 'index before create' do
    p universe.domains.identifiers
  end

  test 'create' do
    p domain = Associations::Domain.new(identifier: identifier)
    p universe.domains.save(domain)
  end

  test 'index after create' do
    p identifiers = universe.domains.identifiers
    raise "#{identifier} not created" unless
    identifiers.map(&:to_s).include?(identifier)
  end

  test 'show' do
    p domain = universe.domains.by(identifier)
    puts domain.to_h.to_yaml
  end

  test 'delete' do
    p domain = universe.domains.by(identifier)
    p universe.domains.delete(domain)
  end

  test 'index after delete' do
    p identifiers = universe.domains.identifiers
    raise "#{identifier} not deleted" if
    identifiers.map(&:to_s).include?(identifier)
  end

end

test_group 'CRUD blueprints' do

  identifier = 'blueprint_for_test'

  test 'index before create' do
    p universe.blueprints.identifiers
  end

  test 'create' do
    p blueprint = Blueprinting::Blueprint.new(identifier: identifier)
    p universe.blueprints.save(blueprint)
  end

  test 'index after create' do
    p identifiers = universe.blueprints.identifiers
    raise "#{identifier} not created" unless
    identifiers.map(&:to_s).include?(identifier)
  end

  test 'show' do
    p blueprint = universe.blueprints.by(identifier)
    puts blueprint.to_h.to_yaml
  end

  test 'delete' do
    p blueprint = universe.blueprints.by(identifier)
    p universe.blueprints.delete(blueprint)
  end

  test 'index after delete' do
    p identifiers = universe.blueprints.identifiers
    raise "#{identifier} not deleted" if
    identifiers.map(&:to_s).include?(identifier)
  end

end

test_group 'Import blueprints' do

  [
    # 'https://github.com/MarkRatjens/test_container.git',
    # 'https://github.com/MarkRatjens/phppgadmin.git',
    'https://github.com/MarkRatjens/poc.git',
  ].each do |repository_url|

    descriptor = Spaces::Descriptor.new(
      repository: repository_url,
    )

    identifier = descriptor.identifier

    test "import #{identifier}" do
      p universe.blueprints.import(descriptor)
    end

    test "index after import #{identifier}" do
      p identifiers = universe.blueprints.identifiers
      raise "blueprint not imported" unless
      identifiers.map(&:to_s).include?(identifier)
    end

  end

end

test_group 'CRUD resolutions' do

  identifier = 'poc'
  descriptor = Spaces::Descriptor.new(identifier: identifier)

  test "show #{identifier} resolution" do
    p universe.resolutions.by(identifier)
  end

  test "index includes #{identifier}" do
    p identifiers = universe.resolutions.identifiers
    raise "#{identifier} not created" unless
    identifiers.map(&:to_s).include?(identifier)
  end

  test 'delete' do
    p resolution = universe.resolutions.by(identifier)
    p universe.resolutions.delete(resolution)
  end

  test 'index after delete' do
    p identifiers = universe.resolutions.identifiers
    raise "#{identifier} not deleted" if
    identifiers.map(&:to_s).include?(identifier)
  end

end

test_group 'CRUD packs' do

  identifier = 'poc'
  descriptor = Spaces::Descriptor.new(identifier: identifier)

  test "show #{identifier} pack" do
    p pack = universe.packing.by(identifier)
    p universe.packing.save(pack)
  end

  test "index includes #{identifier}" do
    p identifiers = universe.packing.identifiers
    raise "#{identifier} not created" unless
    identifiers.map(&:to_s).include?(identifier)
  end

  test 'delete' do
    p pack = universe.packing.by(identifier)
    p universe.packing.delete(pack)
  end

  test 'index after delete' do
    p identifiers = universe.packing.identifiers
    raise "#{identifier} not deleted" if
    identifiers.map(&:to_s).include?(identifier)
  end

end

puts "\e[33mPassed #{ @total - @fails } of #{ @total }\e[0m\n"
