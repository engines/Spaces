class Array

  def to_h_deep
    map do |i|
      i.to_h_deep
    rescue NoMethodError
      i
    end
  end

end
