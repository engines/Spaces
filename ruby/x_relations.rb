require_relative './blueprint/catalogue'
require_relative './blueprint/blueprint'
require_relative './container/space'
require_relative './container/tensor'
require_relative './container/container'
require_relative './environment/space'
require_relative './container/executable'
require_relative './environment/executable'
require_relative './network/executable'
require_relative './executable/executable'
require_relative './executable/tensor'
require_relative './network/space'
require_relative './persistence/space'
require_relative './software/version_descriptor'
require_relative './software/tensor'
require_relative './software/installation'
require_relative './image/tensor'
require_relative './image/image'
require_relative './software/software'
require_relative './network/software'
require_relative './software/license'
require_relative './software/framework'
require_relative './software/space'

def test

  s = Network::Software.new
  s.license = Software::License.new
  s.framework = Software::Framework.new

  v = Software::Version.new
  v.software = s
  v.descriptor = Software::VersionDescriptor.new

  b = Blueprint::Blueprint.new
  b.pages = []
  b.software_version = v
  b.executable_tensor = Executable::Tensor.new
  b.container_tensor = Container::Tensor.new
  b.image_tensor = Image::Tensor.new
  b.software_tensor = Software::Tensor.new

  et = b.executable_tensor
  et.blueprint = b
  et.executable = Executable::Executable.new

  ct = b.container_tensor
  ct.blueprint = b
  ct.container = Container::Container.new

  int = b.software_tensor
  int.software_version = v
  int.blueprint = b
  int.installation = Software::Installation.new

  it = b.image_tensor
  it.installation = int.installation
  it.blueprint = b
  it.image = Image::Image.new

  c = ct.container
  c.tensor = ct
  c.executable = Container::Executable.new

  e = et.executable
  e.tensor = et
  e.container = c.executable
  e.environment = Environment::Executable.new
  e.network = Network::Executable.new

  ee = e.environment
  ee.executable = e

  en = e.network
  en.executable = e

  ss = Software::Space.new
  ps = Persistence::Space.new
  cs = Container::Space.new
  es = Environment::Space.new
  ns = Network::Space.new
end
