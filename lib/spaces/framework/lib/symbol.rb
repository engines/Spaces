require_relative 'identifiable'

class Symbol
  include Identifiable

  def camelize = to_s.camelize
  def snakize = to_s.snakize
  def singularize = to_s.singularize
  def pluralize = to_s.pluralize
  def as_path = to_s.as_path
  def split(*args) = to_s.split(*args)
  def to_hcl(enclosed: false) = %("#{self}")

  def deep(method, _) = to_s.deep(method, _)

  def include?(segment) = to_s.include?(segment.to_s)

  alias_method :underscore, :snakize
  alias_method :no_symbols, :to_s

end
