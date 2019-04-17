module Config where

import           Database.Bolt
import           Data.Default

localCfg :: BoltCfg
localCfg = def { user = "neo4j", password = "fpure" }
