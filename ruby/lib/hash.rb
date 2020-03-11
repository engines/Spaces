class Hash

  def reverse_merge(other = {})
    other.merge(self)
  end

end
