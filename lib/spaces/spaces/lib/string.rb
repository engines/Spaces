class String
  BLANK_RE = /\A[[:space:]]*\z/

  def camelize
    s = sub(/^[a-z\d]*/) { |match| match.capitalize }
    s.gsub!(/(?:_|(\/))([a-z\d]*)/i) { "#{$1}#{$2.capitalize}" }
    s.gsub!("/", "::")
    s
  end

  def snakize
    gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end

  alias_method :underscore, :snakize

  def singularize
    chomp('s')
  end

  def pluralize
    "#{itself}s"
  end

  def blank?
    empty? || BLANK_RE.match?(self)
  end

  def to_h
    self
  end

  alias_method :identifier, :itself
  alias_method :context_identifier, :identifier

  def identifier_separator; '::' ;end
  def with_identifier_separator; self + identifier_separator ;end
  def as_path; gsub(identifier_separator, '/') ;end
  def as_compound; gsub('/', identifier_separator) ;end
  def split_compound; split(identifier_separator) ;end

  def complete?; true ;end
end
