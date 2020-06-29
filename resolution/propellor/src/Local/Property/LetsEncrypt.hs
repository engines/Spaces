
-- ##############################################################
-- ###                                                        ###
-- ###              WARNING: Invective follows                ###
-- ###                                                        ###
-- ###  The only reason this exists is because the person     ###
-- ###  who wrote was far sighted enough to see beyond there  ###
-- ###  own fucking nose and support all the authenticator    ###
-- ###  types that lets Encrypt supports. Which is doubly     ###
-- ###  shit because it was know when this was written.       ###
-- ###                                                        ###
-- ##############################################################

module Local.Property.LetsEncrypt (
    nginxAuthenticator
  , standaloneAuthenticator
  , letsEncrypt
  , letsEncrypt'
  , LetsEncrypt.AgreeTOS(..)
  , Params
  ) where

import           Propellor.Property.LetsEncrypt as LetsEncrypt hiding (letsEncrypt, letsEncrypt')

import           Propellor
import           Propellor.Base

import           System.Posix.Files


type Params = [String]

-- | Uses letsencrypt to obtain a certificate for a domain.
--
-- This should work with any web server, as long as letsencrypt can
-- write its temp files to the web root. The letsencrypt client does
-- not modify the web server's configuration in any way; this only obtains
-- the certificate it does not make the web server use it.
--
-- This also handles renewing the certificate.
-- For renewel to work well, propellor needs to be
-- run periodically (at least a couple times per month).
--
-- This property returns `MadeChange` when the certificate is initially
-- obtained, and when it's renewed. So, it can be combined with a property
-- to make the webserver (or other server) use the certificate:
--
-- > letsEncrypt (AgreeTOS (Just "me@example.com")) "example.com" "/var/www"
-- >  `onChange` Apache.reload
--
-- See `Propellor.Property.Apache.httpsVirtualHost` for a more complete
-- integration of apache with letsencrypt, that's built on top of this.
letsEncrypt :: Domain -> Params -> Property DebianLike
letsEncrypt domain params = letsEncrypt' domain params []


-- | Like `letsEncrypt`, but the certificate can be obtained for multiple
-- domains.
letsEncrypt' :: Domain -> Params -> [Domain] -> Property DebianLike
letsEncrypt' domain params domains =
  prop `requires` installed
    where
      prop :: Property UnixLike
      prop = property desc $ do
        startstats <- liftIO getstats
        (transcript, ok) <- liftIO $ processTranscript "letsencrypt" (params ++ map ("--domain=" <>) alldomains) Nothing
        if ok
          then do
            endstats <- liftIO getstats
            if startstats /= endstats
              then return MadeChange
              else return NoChange
          else do
            liftIO $ hPutStr stderr transcript
            return FailedChange

      desc = "letsencrypt " ++ unwords alldomains
      alldomains = domain : domains

      getstats = mapM statcertfiles alldomains
      statcertfiles d = mapM statfile
        [ certFile d
        , privKeyFile d
        , chainFile d
        , fullChainFile d
        ]

      statfile f = catchMaybeIO $ do
        s <- getFileStatus f
        return (fileID s, deviceID s, fileMode s, fileSize s, modificationTime s)


nginxAuthenticator :: LetsEncrypt.AgreeTOS -> Params
nginxAuthenticator (LetsEncrypt.AgreeTOS memail) = [
    "certonly"
  , "--agree-tos"
  , registrationEmail memail
  , "--authenticator", "nginx"
  , "--nginx"
  , "--text"
  , "--noninteractive"
  , "--keep-until-expiring"
  ]


standaloneAuthenticator :: AgreeTOS -> Params -> Params
standaloneAuthenticator (AgreeTOS memail) extra = [
    "certonly"
  , "--agree-tos"
  , registrationEmail memail
  , "--standalone"
  , "--text"
  , "--noninteractive"
  , "--keep-until-expiring"
  ] ++ extra


registrationEmail :: Maybe Email -> String
registrationEmail = maybe "--register-unsafely-without-email" ("--email=" <>)
