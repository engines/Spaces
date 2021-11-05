require_relative 'identifiable'

class String
  include Identifiable

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
      tr('-', '_').
      downcase
  end

  def constantize
    Module.const_get(self)
  end

  alias_method :underscore, :snakize

  def hyphenated
    tr('-', '_')
  end

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

  alias_method :no_symbols, :to_s

end
