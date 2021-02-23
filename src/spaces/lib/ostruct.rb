require 'ostruct'

class OpenStruct

  def merge(other)
    other ? OpenStruct.new(self.to_h.merge(other.to_h)) : self
  end

  def reverse_merge(other)
    other ? OpenStruct.new(self.to_h.reverse_merge(other.to_h)) : self
  end

  def without(name)
    duplicate(self).tap { |s| s.delete_field(name) if s[name] }
  end

  def keys; to_h.keys ;end

  def to_h_deep
    to_h.transform_values do |v|
      v.to_h_deep
    rescue NoMethodError
      v
    end
  end

end
