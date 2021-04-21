class Hash

  def symbolize_keys
    transform_keys(&:to_sym)
  end

  def stringify_keys
    transform_keys(&:to_s)
  end

  def except(*keys)
    duplicate(self).except!(*keys)
  end

  def except!(*keys)
    keys.each { |key| delete(key) }
    self
  end

  def reverse_merge(other = {})
    other.merge(self)
  end

  def reverse_merge!(other_hash)
    replace(reverse_merge(other_hash))
  end

  def to_json(*args)
    JSON.pretty_generate(self)
  end

  def to_struct
    OpenStruct.new(values_to_struct)
  end

  def values_to_struct
    transform_values do |v|
      v.to_struct
    rescue NoMethodError
      v
    end
  end

end
