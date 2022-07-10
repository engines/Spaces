module Identifiable

  def identifier = self.to_s
  def context_identifier = identifier

  def high = split_compound.first
  def low = split_compound.last

  def identifier_separator = '::'
  def with_identifier_separator = identifier + identifier_separator
  def as_path = gsub(identifier_separator, '/')

  def as_compound(delimiter = '/') =
    gsub(delimiter, identifier_separator)

  def split_compound = split(identifier_separator)
  def subpath = nil

  def as_subdomain = split_compound.reverse.join('.').hyphenated

  def complete? = true

end
