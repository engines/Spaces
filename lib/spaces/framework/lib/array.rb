class Array

  %w(all keys values).each do |w|
    alias_method w, :itself
  end

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

  def in_quotes
    map { |v| %("#{v}")}
  end

  def camelize
    map(&:to_s).map(&:camelize).join('::')
  end

  def constantize
    camelize.constantize
  end

end
