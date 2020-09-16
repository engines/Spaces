require_relative 'hash'

class Array

  def deep_to_h
    map do |i|
      i.deep_to_h
    rescue NoMethodError
      i
    end
  end

end
