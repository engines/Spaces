module Requiring
  include Engines::Logger

  def require_all(dir_name, file_name = '*')
    require_multiple(dir_name, file_name, recurse: true)
  end

  def require_level(dir_name, file_name = '*')
    require_multiple(dir_name, file_name, recurse: false)
  end

  private

  def require_multiple(dir_name, file_name = '*', recurse:)
    pattern = (recurse) ? "**/#{file_name}.rb" : "#{file_name}.rb"
    $LOAD_PATH.map do |p|
      Pathname.new(p).join(dir_name).glob(pattern, &method(:require))
    end
  end
end
