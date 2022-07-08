class Hash

  def symbolize_keys = transform_keys(&:to_sym)

  def stringify_keys = transform_keys(&:to_s)

  def snakize_keys = transform_keys { |k| k.snakize.to_sym }

  def without(*keys) = duplicate(self).without!(*keys)

  def without!(*keys)
    keys.each { |key| delete(key) }
    self
  end

  def clean = compact.delete_if { |k, v| v == '' }

  def reverse_merge(other) = other ? other.merge(self) : self

  def reverse_merge!(other_hash)
    replace(reverse_merge(other_hash))
  end

  def to_struct =
    OpenStruct.new(snakize_keys.values_to_struct)

  def to_hcl(enclosed: true) =
    %(#{'{' if enclosed}
      #{keys.map { |k| hcl_for(k) }.join("\n")}
      #{'}' if enclosed}
    )

  def hcl_for(key) =
    %(#{key} = #{self[key].to_hcl})

  def no_symbols = stringify_keys.deep(:no_symbols)
  def values_to_struct = deep(:to_struct)

  def deep(method)
    transform_values do |v|
      v.send(method)
    rescue NoMethodError
      v
    end
  end

end
