require './web/app/base'
require './web/app/helpers'
require './web/app/client'
require './web/app/api'

class String
  def camelize
    return self.split('_').map(&:camelize).join if self.match(/_/)
    self[0] = self[0].upcase
    self
  end
end

class Symbol
  def camelize
    to_s.camelize
  end
end
