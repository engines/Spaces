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

  def underscore
    snakize.gsub('/', '_')
  end

  def constantize
    Module.const_get(self)
  end

  def hyphenated
    tr('_', '-')
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

  def downcase_first
    dup.tap do |d|
      d[0] = d[0].downcase
    end
  end

  def to_h
    self
  end

  def to_hcl
    hcl_variable? ? self : %("#{self}")
  end

  def hcl_variable?
    # HACKY!
    split('.').compact.count == 3
  end

  alias_method :no_symbols, :to_s

end
