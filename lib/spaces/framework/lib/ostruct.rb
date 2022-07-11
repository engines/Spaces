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

  def to_h_deep = deep(:to_h_deep)
  def no_symbols = deep(:no_symbols)

  def deep(method)
    to_h.transform_values do |v|
      v.send(method)
    rescue NoMethodError
      v
    end
  end

end
