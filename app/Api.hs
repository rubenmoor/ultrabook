{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DataKinds     #-}

module Api
  ( Routes (..)
  ) where

import           Data.Text                (Text)

import           Servant                  ((:>), Application, Capture, Get,
                                           PlainText)
import           Servant.API.Generic      ((:-), Generic, ToServantApi,
                                           genericApi)

data Routes route = Routes
  { _getChapter :: route :- "chapter" :> Capture "id" Text :> Get '[PlainText] Text
  , _getBook :: route :- "book" :> Get '[PlainText] Text
  } deriving (Generic)
