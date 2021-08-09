require 'ostruct'

class OpenStruct

  def merge(other)
    other ? OpenStruct.new(self.to_h.merge(other.to_h)) : self
  end

  def reverse_merge(other)
    other ? OpenStruct.new(self.to_h.reverse_merge(other.to_h)) : self
  end

  def without(*keys)
    duplicate(self).tap do |s|
      keys.flatten.each { |k| s.delete_field(k) if s[k] }
    end
  end

  def keys; to_h.keys ;end

  def compact; to_h_deep.compact.to_struct ;end

  def to_json(*args)
    to_h_deep.to_json(*args)
  end

  def to_h_deep
    to_h.transform_values do |v|
      v.to_h_deep
    rescue NoMethodError
      v
    end
  end

end
