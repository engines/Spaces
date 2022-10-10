class Pathname

  def exist_then(&block)
    yield(self) if exist? && block_given?
  end

  def delete_if_empty
    delete if empty?
  end

  def without_ext = sub_ext('')
    
  def split(*args) = to_s.split(*args)

  def to_sym = to_s.to_sym

end
