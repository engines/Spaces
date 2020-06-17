require './ruby/universal/space'
require './ruby/blueprints/blueprint'
# require './ruby/resolutions/resolution'
# require './ruby/domains/domain'
# require './ruby/users/user'
require 'byebug'

universe = Universal::Space.new

resources = {
  blueprints: Blueprints::Blueprint,
  # users: Users::User,
  # domains: Domains::Domain,
}

@total = 0
@fails = 0
def test
  @total += 1
  yield
  puts "\e[32mOK\e[0m"
rescue => e
  @fails += 1
  puts "\e[31mERROR\e[0m\n#{e.full_message}"
ensure
  puts "\n"
end

n1 = 0

puts "#{n1 += 1}. blueprints\n\n"

id = 'blueprint_for_test'
n2 = 0

s = universe.blueprints
d = Spaces::Descriptor.new(identifier: id)

test do
  puts "#{n1}.#{n2 += 1} index before create"
  p s.identifiers
end

test do
  puts "#{n1}.#{n2 += 1} create"
  p o = Blueprints::Blueprint.new(descriptor: d)
  p s.save(o)
end

test do
  puts "#{n1}.#{n2 += 1} index after create"
  p s.identifiers
  raise "#{id} not created" unless s.identifiers.map(&:to_s).include?(id)
end

test do
  puts "#{n1}.#{n2 += 1} show"
  p o = s.by(d)
  puts o.to_json
end

test do
  puts "#{n1}.#{n2 += 1} delete"
  p o = s.by(d)
  p s.delete(o)
end

test do
  puts "#{n1}.#{n2 += 1} index after delete"
  p s.identifiers
  raise "#{id} not deleted" if s.identifiers.map(&:to_s).include?(id)
end


puts "#{n1 += 1}. Resolutions\n\n"

id_blueprint = 'waverton'
id_resolution = "#{id_blueprint}_install"
sb = universe.blueprints
si = universe.resolutions
d_blueprint = Spaces::Descriptor.new(identifier: id_blueprint)
d_resolution = Spaces::Descriptor.new(identifier: id_resolution)
b = sb.by(d_blueprint)
n2 = 0

test do
  puts "#{n1}.#{n2 += 1} index before create"
  puts si.identifiers
end

test do
  puts "#{n1}.#{n2 += 1} #{id_blueprint} present"
  p b.to_json
end

test do
  puts "#{n1}.#{n2 += 1} create on blueprint"
  p universe.resolutions.save(
    Resolutions::Resolution.new(
      blueprint: b,
      descriptor: d_resolution
    )
  )
end

test do
  puts "#{n1}.#{n2 += 1} index after create"
  puts si.identifiers
  raise "#{id_resolution} not created" unless si.identifiers.map(&:to_s).include?(id_resolution)
end

test do
  puts "#{n1}.#{n2 += 1} index on blueprint"
  bi = universe.resolutions.descriptors.select do |d|
    debugger
    d.repository == b.descriptor.repository
  end.map(&:identifier).map(&:to_s).sort
  p bi
end

test do
  puts "#{n1}.#{n2 += 1} delete"
  p o = si.by(d_resolution)
  p si.delete(o)
end

test do
  puts "#{n1}.#{n2 += 1} index after delete"
  puts si.identifiers
  raise "#{id_resolution} not deleted" if si.identifiers.map(&:to_s).include?(id_resolution)
end

puts "\e[33mPassed #{ @total - @fails } of #{ @total }\e[0m\n"
