module Abbreviating

  def abbreviated_to(l, separator = '-')
    s = abbreviation_methods(l, separator).reduce(self) do |m, args|
      m.length > l ? m.send(*args) : m
    end
  end

  def abbreviation_methods(l, separator = '-')
    [
      [:no_vowels_except_after, separator],
      [:segments_trancated_to, 4],
      [:without_delimiter, separator],
      [:[], 0, l - 1]
    ]
  end

  def no_vowels_except_after(separator) =
    split(separator).map(&:no_nonleading_vowels).join(separator)

  def segments_trancated_to(l, separator = '-')
    split(separator).map do |s|
      s.integer? ? s.reverse : s[0, l]
    end.join(separator)
  end

  def no_nonleading_vowels =
    length > 4 ? "#{chr}#{self[1..-1].no_vowels}" : self

  def no_vowels = gsub(/[aeiouy]/i, '')
  def integer? = to_i.to_s == self
  def without_delimiter(separator = '-') = gsub(separator, '')

end
