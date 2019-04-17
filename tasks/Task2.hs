module Main where

import           Control.Monad
import           Data.Function                  ( (&) )
import qualified Data.Map.Strict               as Map
import           Data.Text                      ( Text
                                                , intercalate
                                                , unpack
                                                )
import           Database.Bolt           hiding ( unpack )
import           Database.Bolt.Extras.Graph

import           Config
import           Types

-- | **ЗАДАЧА**
-- Напишите запрос, который вернет людей, с которыми говорил Люк, и фильмы в которых они
-- появлялись аналогично предыдущей задаче, с использованием шаблонов графов.
lukeGraph :: GraphGetRequest
lukeGraph = undefined

main :: IO ()
main = do
  pipe <- connect localCfg
  res  <- run pipe $ makeRequest @GetRequest [] lukeGraph

  -- Разберите ответ аналогично предыдущей задаче.
  let talking = undefined :: Map.Map Text [Text]

  putStrLn "Characters Luke talks to:"
  forM_ (Map.toList talking) $ \(movie, characters) ->
    putStrLn $ unpack $ movie <> ": " <> intercalate ", " characters

