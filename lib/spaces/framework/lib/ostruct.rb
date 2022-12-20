require 'ostruct'

class OpenStruct

  def merge(other) =
    other ? OpenStruct.new(self.to_h.merge(other.to_h)) : self

  def reverse_merge(other) =
    other ? OpenStruct.new(self.to_h.reverse_merge(other.to_h)) : self

  def without(*keys)
    duplicate(self).tap do |s|
      keys.flatten.each { |k| s.delete_field(k) if s[k] }
    end
  end

  def keys = to_h.keys
  def values = to_h.values

  def compact = to_h_deep.compact.to_struct

  def to_json(*args) = to_h_deep.to_json(*args)

  def to_string_array = keys.map { |k| "#{k}=#{send(k)}"}

  def no_symbols = deep(:no_symbols)

  def deep(method, of: :values)
    to_h.send("transform_#{of}") { |v| v.deep(method, of: of) }.
    transform_values { |v| (v.respond_to?(:keys) && of == :keys) ? v.deep(method, of: :keys) : v }
  end
  def deep_to_h = to_h.deep_to_h

end
