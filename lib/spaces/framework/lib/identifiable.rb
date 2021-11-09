module Identifiable

  def identifier; self.to_s ;end
  def context_identifier; identifier ;end

  def identifier_separator; '::' ;end
  def with_identifier_separator; identifier + identifier_separator ;end
  def as_path; gsub(identifier_separator, '/') ;end
  def as_subdomain; gsub(identifier_separator, '.').hyphenated ;end
  def as_compound; gsub('/', identifier_separator) ;end
  def split_compound; split(identifier_separator) ;end
  def subpath; nil ;end

  def complete?; true ;end

end
