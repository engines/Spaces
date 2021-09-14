module Git

  def self.clone(repository, name, options = {}, &block)
    Base.clone(repository, name, options, &block)
  end

end
