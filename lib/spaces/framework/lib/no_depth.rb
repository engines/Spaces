module NoDepth

  def deep(method, _) = to_s.send(method)

  def to_h = self
  def deep_to_h = self

  def to_struct = self
  def deep_to_struct = self

  def compact = self

end
