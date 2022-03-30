# load the code!
require './x/controllers'

controllers.images.list
controllers.images.index
controllers.images.show(identifier: 'development::phpmyadmin')
controllers.images.delete(identifier: 'development::phpmyadmin')
