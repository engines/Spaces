require_relative '../spaces/model'

class Software < ::Spaces::Model
  class Package < ::Spaces::Model

#/home/app is prefaced by docker image build space dir
# for each package
#do
#step 1
# download or git clont to a directory under /tmp
#methods are http(s) ftp(s) or git
#git can be either git user@hostname:/path or https://host/path
#support for username and password -- expect these in the tensor
#latter also support for ssh keys
#SSL_Verify on or off based on flag in bp
# extract if extract cmd set, extrace command may have options

#step 2
# if destination is ./ /app or /home/app mv the extraced (or cloned) dir to /home/app
# elif destination is under /home/app then create dirname (destination) must ensure destination is prefixed by //home/app
# sometimes a package is just a single file.
# mv is preffered by sometimes cp -rp is used if teh destination exists
#
#clean up whateve is left in tmp
# next

  end
end
