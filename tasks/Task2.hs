module Main where

import           Control.Monad
import           Control.Monad.State
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
lukeGraph =
  emptyGraph
    & addNode
        "luke"
        ( defaultNodeReturn
        & withLabelQ ''Person
        & withProp ("name", T "LUKE")
        & withReturn allProps
        )
    & addNode "someone"
              (defaultNodeReturn & withLabelQ ''Person & withReturn allProps)
    & addNode "movie"
              (defaultNodeReturn & withLabelQ ''Movie & withReturn allProps)
    & addRelation "luke"
                  "someone"
                  (defaultRelNotReturn & withLabelQ ''SPEAKS_WITH)
    & addRelation "someone" "movie" (defaultRelReturn & withLabelQ ''APPEARS_IN)

main :: IO ()
main = do
  pipe <- connect localCfg
  res  <- run pipe $ makeRequest @GetRequest [] lukeGraph

  -- Разберите ответ аналогично предыдущей задаче.
  let talking = flip execState mempty $ forM_ res $ \graph -> do
        let Movie movieName    = extractNode "movie" graph
        let Person someoneName = extractNode "someone" graph

        modify $ Map.insertWith (<>) movieName [someoneName]

  putStrLn "Characters Luke talks to:"
  forM_ (Map.toList talking) $ \(movie, characters) ->
    putStrLn $ unpack $ movie <> ": " <> intercalate ", " characters

