module Identifiable

  def identifier; self ;end
  def context_identifier; identifier ;end

  def identifier_separator; '::' ;end
  def with_identifier_separator; self + identifier_separator ;end
  def as_path; gsub(identifier_separator, '/') ;end
  def as_compound; gsub('/', identifier_separator) ;end
  def split_compound; split(identifier_separator) ;end
  def subpath; nil ;end

  def complete?; true ;end

end
