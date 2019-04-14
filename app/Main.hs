{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE RankNTypes    #-}
{-# LANGUAGE TypeOperators #-}

module Main
  ( main
  ) where

import           Control.Exception        (throwIO)
import           Data.Proxy               (Proxy (..))
import           Data.Text                (Text)

import           Network.Wai.Handler.Warp (run)
import           Servant                  ((:>), Application, Capture, Get,
                                           PlainText)
import           Servant.Server.Generic   (AsServer, genericServe)
import           Servant.API.Generic      ((:-), Generic, ToServantApi,
                                           genericApi)

import           Api                      (Routes (..))

api :: Proxy (ToServantApi Routes)
api = genericApi (Proxy :: Proxy Routes)

handler :: Routes AsServer
handler = Routes
  { _getChapter = pure
  , _getBook = pure "This is the whole book"
  }

app :: Application
app = genericServe handler

main :: IO ()
main = do
  putStrLn "Running on port 8000 ..."
  run 8000 app
