require_relative 'identifiable'

class Symbol
  include Identifiable

  def camelize; to_s.camelize ;end
  def snakize; to_s.snakize ;end
  def singularize; to_s.singularize ;end
  def pluralize; to_s.pluralize ;end
  def as_path; to_s.as_path ;end

  alias_method :underscore, :snakize
  alias_method :no_symbols, :to_s

end
