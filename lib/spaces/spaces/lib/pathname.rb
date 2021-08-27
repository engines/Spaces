class Pathname

  def exist_then(&block)
    yield(self) if exist? && block_given?
  end

  def delete_if_empty
    delete if empty?
  end

end
