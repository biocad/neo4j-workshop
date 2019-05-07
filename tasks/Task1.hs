module Main where

import           Control.Lens            hiding ( at )
import           Control.Monad
import qualified Data.Map.Strict               as Map
import           Data.Text                      ( Text
                                                , intercalate
                                                , unpack
                                                )
import           Database.Bolt           hiding ( unpack )
import           Database.Bolt.Lens      hiding ( exact )

import           Config

countQ :: Text
countQ =
  "MATCH (m:Movie) -[:APPEARS_IN]- (character) \
  \RETURN m.title AS movie, count(character) AS characters"

-- | **ЗАДАНИЕ**
-- Запрос должен найти всех людей, с которыми говорил Люк ('LUKE'), а также фильмы, в которых
-- они появлялись.
lukeQ :: Text
lukeQ = undefined

main :: IO ()
main = do
  pipe <- connect localCfg
  res  <- run pipe $ query countQ

  putStrLn "Number of characters in movies"
  forM_ res $ \rec -> do
    movie      <- rec `at` "movie" >>= exact @Text
    characters <- rec `at` "characters" >>= exact @Int

    putStrLn $ unpack movie <> ": " <> show characters <> " characters."

    -- **ЗАДАНИЕ**
    -- Из полученного ответа достать название фильма (Text в поле "movie") и число персонажей
    -- (Int в поле "characters"). Вывести на экран.

  res2 <- run pipe $ query lukeQ

  -- **ЗАДАНИЕ**
  -- Разобрать ответ на запрос lukeQ. Сохранить результат в словарь Map, ключ -- название фильма,
  -- значение.
  -- Подсказка -- для заполнения Map можно воспользоваться Control.Monad.State
  let talking = undefined :: Map.Map Text [Text]

  putStrLn "Characters Luke talks to:"
  forM_ (Map.toList talking) $ \(movie, characters) ->
    putStrLn $ unpack $ movie <> ": " <> intercalate ", " characters

