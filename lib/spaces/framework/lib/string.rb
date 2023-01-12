require_relative 'identifiable'
require_relative 'abbreviating'

class String
  include Identifiable
  include Abbreviating

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

  def constantize = Module.const_get(self)

  def hyphenated
    tr('_', '-')
  end

  def singularize = chomp('s')

  def pluralize = "#{itself}s"

  def blank? = empty? || BLANK_RE.match?(self)

  def downcase_first
    dup.tap do |d|
      d[0] = d[0].downcase
    end
  end

  def to_hcl(enclosed: false) = %("#{self}")

  def deep(method, _) = send(method)

  alias_method :no_symbols, :to_s

end
