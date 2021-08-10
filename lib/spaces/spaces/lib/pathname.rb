class Pathname

  def exist_then(&block)
    yield(self) if exist? && block_given?
  end

end
