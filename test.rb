require './ruby/universal/space'
require './ruby/blueprints/blueprint'
require './ruby/installations/installation'
require './ruby/domains/domain'
require './ruby/users/user'
require 'byebug'

u = Universal::Space.new

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

s = u.blueprints
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
  puts o.to_h.to_yaml
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


puts "#{n1 += 1}. Installations\n\n"

idb = 'waverton'
idi = "#{idb}_install"
sb = u.blueprints
si = u.installations
db = Spaces::Descriptor.new(identifier: idb)
di = Spaces::Descriptor.new(identifier: idi)
b = sb.by(db)
n2 = 0

test do
  puts "#{n1}.#{n2 += 1} index before create"
  puts si.identifiers
end

test do
  puts "#{n1}.#{n2 += 1} #{idb} present"
  p b.to_json
end

test do
  puts "#{n1}.#{n2 += 1} create on blueprint"
  p u.installations.save(
    Installations::Installation.new(
      blueprint: b,
      descriptor: di
    )
  )
end

test do
  puts "#{n1}.#{n2 += 1} index after create"
  puts si.identifiers
  raise "#{idi} not created" unless si.identifiers.map(&:to_s).include?(idi)
end

test do
  puts "#{n1}.#{n2 += 1} index on blueprint"
  bi = u.installations.descriptors.select do |d|
    d.repository == b.descriptor.repository
  end.map(&:identifier).map(&:to_s).sort
  p bi
end

test do
  puts "#{n1}.#{n2 += 1} delete"
  p o = si.by(di)
  p si.delete(o)
end

test do
  puts "#{n1}.#{n2 += 1} index after delete"
  puts si.identifiers
  raise "#{idi} not deleted" if si.identifiers.map(&:to_s).include?(idi)
end

puts "\e[33mPassed #{ @total - @fails } of #{ @total }\e[0m\n"

#
# require './ruby/universal/space'
# require './ruby/blueprints/blueprint'
# u = Universal::Space.new
# s = u.blueprints
# id = 'blueprint_for_test'
# d = Spaces::Descriptor.new(identifier: id)
# o = Projects::Project.new(descriptor: d)
# s.save(o)
# s.identifiers.include?(id)
#
# # require './ruby/universal/space'
# # require './ruby/blueprints/blueprint'
# # u = Universal::Space.new
# require './ruby/x/test_container'
# s = universe.blueprints
# s.identifiers
# import
# s.identifiers
# d = Spaces::Descriptor.new(identifier: 'waverton')
# o = s.by(d)
# o.title
