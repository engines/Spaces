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

  def transform_keys(&block) = self.class.new(to_h.transform_keys(&block))
  def transform_values(&block) = self.class.new(to_h.transform_values(&block))

  def compact = deep(:compact)

  def to_json(*args) = deep_to_h.to_json(*args)

  def to_string_array = keys.map { |k| "#{k}=#{send(k)}"}

  def no_symbols = deep(:no_symbols)

  def deep(method, of: :values) = to_h.deep(method, of: of).deep_to_struct

  def deep_to_h = to_h.deep_to_h

  def deep_to_struct =
    self.class.new(deep_to_h)

end
