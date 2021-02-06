class Symbol
  def camelize; to_s.camelize ;end
  def snakize; to_s.snakize ;end
  def singularize; to_s.singularize ;end
  def pluralize; to_s.pluralize ;end

  alias_method :underscore, :snakize

end
