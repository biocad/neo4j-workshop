module Main where

import           Control.Lens                   ( to
                                                , (&)
                                                , (^?!)
                                                )
import           Control.Monad
import           Data.Map.Strict                ( (!) )
import           Data.Text                      ( Text
                                                , unpack
                                                )
import           Database.Bolt           hiding ( unpack )
import           Database.Bolt.Extras
import           Database.Bolt.Extras.Graph
import           Database.Bolt.Lens      hiding ( exact )

import           Config
import           Types

anakinQ :: Text
anakinQ =
  "MATCH (anakin:Person) -[:APPEARS_IN]- (movie:Movie) \
  \WHERE anakin.name = 'ANAKIN' \
  \RETURN movie"

anakinGraph :: GraphGetRequest
anakinGraph =
  emptyGraph
    & addNode
        "anakin"
        (defaultNodeNotReturn & withLabelQ ''Person & withProp
          ("name", T "ANAKIN")
        )
    & addNode "movie"
              (defaultNodeReturn & withLabelQ ''Movie & withReturn allProps)
    & addRelation "anakin"
                  "movie"
                  (defaultRelNotReturn & withLabelQ ''APPEARS_IN)

main :: IO ()
main = do
  pipe <- connect localCfg
  res  <- run pipe $ query anakinQ

  putStrLn "All movies with Anakin"
  putStrLn ""

  putStrLn "Extracting wihtout lenses"
  forM_ res $ \rec -> do
    movie     <- rec `at` "movie" >>= exact
    movieName <- exact $ nodeProps movie ! "title"
    putStrLn $ unpack movieName
  putStrLn ""

  putStrLn "Extracting with lenses"
  forM_ res $ \rec -> do
    let movieName = rec ^?! field "movie" . prop "title"
    putStrLn $ unpack movieName
  putStrLn ""

  putStrLn "Extracting with TemplateHaskell"
  forM_ res $ \rec -> do
    let Movie movieName = rec ^?! field "movie" . to fromNode
    putStrLn $ unpack movieName
  putStrLn ""

  putStrLn "Extracting with sub-graph query"
  gres <- run pipe $ makeRequest @GetRequest [] anakinGraph
  forM_ gres $ \graph -> do
    let Movie movieName = extractNode "movie" graph
    putStrLn $ unpack movieName
