class Array

  %w(all keys values).each do |w|
    alias_method w, :itself
  end

  def to_h_deep; deep(:to_h_deep) ;end
  def to_struct; deep(:to_struct) ;end
  def no_symbols; deep(:no_symbols) ;end

  def deep(method)
    map do |i|
      i.send(method)
    rescue NoMethodError
      i
    end
  end

  def all_true?
    !any?(false)
  end

  def select_uniq(&block)
    select(&block).uniq(&block)
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
