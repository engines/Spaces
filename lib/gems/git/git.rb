module Git

  def self.clone(repository_url, directory = nil, options = {}, &block)
    clone_to_options = options.select { |key, _value| %i[bare mirror].include?(key) }
    directory ||= Git::URL.clone_to(repository_url, **clone_to_options)
    Base.clone(repository_url, directory, options, &block)
  end

end
