module Types where

import           Data.Text                      ( Text )

import           Database.Bolt.Extras.Template

data Movie = Movie
  { title :: Text
  }

data Person = Person
  { name :: Text
  }

data SPEAKS_WITH = SPEAKS_WITH
data APPEARS_IN = APPEARS_IN

makeNodeLike ''Movie
makeNodeLike ''Person

makeURelationLike ''SPEAKS_WITH
makeURelationLike ''APPEARS_IN
