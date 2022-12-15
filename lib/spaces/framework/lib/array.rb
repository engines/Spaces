class Array

  %w(all keys values).each do |w|
    alias_method w, :itself
  end

  def to_h_deep = deep(:to_h_deep)
  def to_struct = deep(:to_struct)
  def no_symbols = deep(:no_symbols)

  def to_hcl_without_quotes(**args) = to_hcl(**args).gsub('"', '')

  def to_hcl(enclosed: true) =
    %(#{'[' if enclosed}
      #{deep(:to_hcl).join(",\n")}
      #{']' if enclosed}
    )

  def deep(method, of:)
    map do |i|
      i.deep(method, of: of)
    rescue NoMethodError
      i
    end
  end

  def exclude?(object) = !include?(object)

  def all_true? = !any?(false)

  def select_uniq(&block) = select(&block).uniq(&block)

  def in_quotes = map { |v| %("#{v}")}

  def camelize = map(&:to_s).map(&:camelize).join('::')

  def constantize = camelize.constantize

  def drop(integer) = take(count - integer)

  def split(value)
    if (i = index(value))
      [
        (i > 0 ? self[0..i-1] : []),
        self[i+1..-1]
      ]
    else
      self
    end
  end

  def nilify
    self unless self.empty?
  end

end
