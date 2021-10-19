module Requiring

  ## Requires files with `.rb` extension,
  ## descending directory structure recursively,
  ## from many starting directories (relative to caller location).
  ## Examples:
  ## - `requires 'foo', 'bar'`
  ## - `requires 'foo', recurse: false`
  ## - `requires 'foo', only: ['this', 'that']`
  ## Options:
  ## - recurse: set to `false` to require directory files and not subdirectories files.
  ## - only: require matching entries only
  def requires(*entry_names, **options)
    locate(caller_locations) do |location|
      entry_names.each do |entry_name|
        require_children(location.join(entry_name), options)
      end
    end
  end

  private

  def locate(locations)
    yield Pathname.new(locations.first.path).dirname
  end

  def require_children(directory, recurse: true, only: nil)
    directory.children.sort.tap do |entries|
      require_file_entries(entries, only: only)
      require_dir_entries(entries, only: only) if recurse
    end
  end

  def require_file_entries(entries, only: nil)
    entries.each do |entry|
      next unless entry.file? && entry.extname == '.rb'
      next if only && !only.include?("#{entry.basename.sub_ext('')}")
      require "#{entry}"
    end
  end

  def require_dir_entries(entries, only: nil)
    entries.each do |entry|
      next unless entry.directory?
      next if only && !only.include?(entry.basename)
      require_children(entry, recurse: true)
    end
  end
end
