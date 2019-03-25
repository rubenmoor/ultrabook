{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeOperators #-}

module Main
  ( main
  ) where

import Control.Exception (throwIO)
import Data.Proxy (Proxy (..))
import Data.Text (Text)

import Network.Wai.Handler.Warp (run)
import Servant (Capture, (:>), Get, PlainText, Application)
import Servant.Server.Generic (AsServer, genericServe)
import Servant.API.Generic (Generic, (:-), ToServantApi, genericApi)

import           Lib (func)

data Routes route = Routes
  { _getChapter :: route :- "chapter" :> Capture "id" Text :> Get '[PlainText] Text
  , _getBook :: route :- "book" :> Get '[PlainText] Text
  } deriving (Generic)

api :: Proxy (ToServantApi Routes)
api = genericApi (Proxy :: Proxy Routes)

record :: Routes AsServer
record = Routes
  { _getChapter = pure
  , _getBook = pure "This is the whole book"
  }

app :: Application
app = genericServe record

main :: IO ()
main = do
  putStrLn "Running on port 8000 ..."
  run 8000 app
