class Hash

  def reverse_merge(other = {})
    other.merge(self)
  end
  
  def reverse_merge!(other_hash)
    replace(reverse_merge(other_hash))
  end

  def to_struct
    OpenStruct.new(itself)
  end
  
end
