module Main where

-- This is the main configuration file for Propellor, and is used to build
-- the propellor program.

import           Propellor

import qualified Propellor.Property.Apt as Apt
import qualified Propellor.Property.File as File
import qualified Propellor.Property.Hostname as Hostname
import qualified Propellor.Property.Nginx as Nginx
import qualified Propellor.Property.Ssh as Ssh

-- import qualified Local.Property.LetsEncrypt as LetsEncrypt

type Motd = [String]

type Email = String


main :: IO ()
main = defaultMain hosts


-- | List of hosts that propellor knows about.
hosts :: [Host]
hosts = [
    postgres
  , rails
  , wap
  ]


--------------------------------------------------------
------               Useful constants             ------
--------------------------------------------------------


adminEmail :: Email
adminEmail = "rgh@filterfish.org"


domain :: Domain
domain = "int.engines.org"


defaultSuite :: DebianSuite
defaultSuite = Stable "beowulf"


commonPackages :: [String]
commonPackages = requiredPackages <> optionalPackages
  where
    -- | Packages that really should be there.
    requiredPackages = ["locales-all"]

    -- | Packages that don't really need to be there but make life easier
    optionalPackages = ["ncurses-term" , "ssh", "vim"]


--------------------------------------------------------
------               Host definitions             ------
--------------------------------------------------------


-- | Database server
postgres :: Host
postgres = host' "postgres" $ props
  & standardSystem defaultSuite [ "Postgresql Database Server" ]
  & Apt.installed ["postgresql-11"]


-- | Application server
rails :: Host
rails = host' "rails" $ props
  & standardSystem defaultSuite [ "Application Server" ]
  & Apt.installed ["postgresql-11", "redis"]


-- | Nginx Front end
wap :: Host
wap = host' "wap" $ props
  & standardSystem defaultSuite [ "WAP Server" ]

  -- & LetsEncrypt.letsEncrypt fqdn standalone_authenticator

  & Nginx.installed
  & Nginx.siteEnabled "redirect" nginxHttpsRedirect
  & Nginx.siteEnabled "rails" (nginxProxyTemplate fqdn proxy resolver)
  & revert (Nginx.siteEnabled "default" [])

  where
    fqdn = "wap." <> domain
    proxy = "rails." <> domain
    resolver = "ns1." <> domain
    -- standalone_authenticator = LetsEncrypt.standaloneAuthenticator (LetsEncrypt.AgreeTOS (Just adminEmail)) [
    --     "--staple-ocsp"
    --   , "--must-staple"
    --   , "--hsts"
    --   , "--rsa-key-size", "4096"
    --   ]


--------------------------------------------------------
------       Setup common to all containers       ------
--------------------------------------------------------


-- | Standard bas config
standardSystem :: DebianSuite -> Motd -> Property (HasInfo + Debian)
standardSystem suite motd =
  standardSystemUnhardened suite X86_64 motd `before` Ssh.noPasswords


-- | Standard base config
standardSystemUnhardened :: DebianSuite -> Architecture -> Motd -> Property (HasInfo + Debian)
standardSystemUnhardened suite arch motd = propertyList "standard system" $ props
  & osDebian suite arch
  & Hostname.sane
  & Hostname.searchDomain
  & File.hasContent "/etc/motd" (emptyLine : motd <> emptyLines)
  & Apt.installed commonPackages


--------------------------------------------------------
------               Useful functions             ------
--------------------------------------------------------

-- | Wraps @host@ and appends the domain name to the host.
host' :: HostName -> Props metatypes -> Host
host' h = host (h <> "." <> domain)


-- | List of @emptyLine@
emptyLines :: [File.Line]
emptyLines = [emptyLine]


-- | Returns an emptyLine. Useful when constructing configuration files
emptyLine :: File.Line
emptyLine = ""



--------------------------------------------------------
------               Nginx templates              ------
--------------------------------------------------------

nginxHttpsRedirect :: [File.Line]
nginxHttpsRedirect = [ -- {{{
    "server {"
  , "    listen 80 default_server;"
  , "    listen [::]:80 default_server;"
  , emptyLine
  , "    # Redirect all HTTP requests to HTTPS with a 301 Moved Permanently response."
  , "    return 301 https://$host$request_uri;"
  , "}"
  ] -- }}}


nginxProxyTemplate :: String -> String -> String -> [File.Line]
nginxProxyTemplate fqdn proxy resolver = [ -- {{{
    "server {"
  , "    listen 443 ssl http2 default_server;"
  , "    listen [::]:443 ssl http2 default_server;"
  , emptyLine
  , "    server_name " <> fqdn <> ";"
  , emptyLine
  , "    location / {"
  , "      proxy_pass          " <> proxy <> ";"
  , "      proxy_set_header    Host " <> fqdn <> ";"
  , "      proxy_set_header    X-Real-IP $remote_addr;"
  , "      proxy_set_header    X-Forwarded-Proto http;"
  , "      proxy_set_header    X-Forwarded-For $remote_addr;"
  , "    }"
  , emptyLine
  , "    access_log  /var/log/nginx/" <> fqdn <> ".access.log;"
  , "    error_log   /var/log/nginx/" <> fqdn <> ".error.log;"
  , emptyLine
  , "    ## verify chain of trust of OCSP response using Root CA and Intermediate certs"
  , "    ssl_trusted_certificate /etc/letsencrypt/live/" <> fqdn <> "/fullchain.pem;"
  , emptyLine
  , "    ssl_certificate /etc/letsencrypt/live/" <> fqdn <> "/fullchain.pem;"
  , "    ssl_certificate_key /etc/letsencrypt/live/" <> fqdn <> "/privkey.pem;"
  , "    ssl_protocols TLSv1.2;"
  , "    ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256';"
  , "    ssl_prefer_server_ciphers on;"
  , "    ssl_session_timeout 1d;"
  , "    ssl_session_cache shared:SSL:50m;"
  , "    ssl_session_tickets off;"
  , emptyLine
  , "    # HSTS (ngx_http_headers_module is required) (15768000 seconds = 6 months)"
  , "    add_header Strict-Transport-Security max-age=15768000;"
  , emptyLine
  , "    # OCSP Stapling ---"
  , "    # fetch OCSP records from URL in ssl_certificate and cache them"
  , "    ssl_stapling on;"
  , "    ssl_stapling_verify on;"
  , emptyLine
  , "    resolver " <> resolver <> ";"
  , "}"
  ] -- }}}

-- vim: set fdm=marker:
