require 'ostruct'
require_relative 'hash'

class OpenStruct

  def merge(other)
    OpenStruct.new(self.to_h.merge(other&.to_h))
  end

  def reverse_merge(other)
    OpenStruct.new(self.to_h.reverse_merge(other&.to_h))
  end

  def deep_to_h
    to_h.transform_values do |v|
      case v
      when OpenStruct
        v.deep_to_h
      when Array
        v.map(&:deep_to_h)
      else
        v
      end
    rescue NoMethodError
      v
    end
  end

end
