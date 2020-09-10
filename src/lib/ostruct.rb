require 'ostruct'
require_relative 'hash'

class OpenStruct

  def merge(other)
    other ? OpenStruct.new(self.to_h.merge(other.to_h)) : self
  end

  def reverse_merge(other)
    other ? OpenStruct.new(self.to_h.reverse_merge(other.to_h)) : self
  end

  def deep_to_h
    to_h.transform_values do |v|
      v.deep_to_h
    rescue NoMethodError
      v
    end
  end

  def memento; duplicate(self) ;end

end
