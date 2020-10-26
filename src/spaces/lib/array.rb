class Array

  def to_h_deep
    map do |i|
      i.to_h_deep
    rescue NoMethodError
      i
    end
  end

  def to_struct
    map do |i|
      i.to_struct
    rescue NoMethodError
      i
    end
  end

  def all_true?
    !any?(false)
  end

end
