require_relative 'no_depth'

class Object
  include NoDepth
  
  def to_hcl = self
  def deep(*) = self

  def no_symbols = self

end
