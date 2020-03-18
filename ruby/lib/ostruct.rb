require 'ostruct'
require_relative 'hash'

class OpenStruct

  def merge(other)
    OpenStruct.new(self.to_h.merge(other&.to_h))
  end

  def reverse_merge(other)
    OpenStruct.new(self.to_h.reverse_merge(other&.to_h))
  end

end
