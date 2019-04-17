# Воркшоп по Neo4j + Haskell на FPURE

В этом репозитории лежит пример кода и задачи по работе с БД Neo4j на Haskell.

## Установка инструментов

Для выполнения задач на воркшопе вам понадобятся следующие инструменты.

### Docker

Docker используется для запуска самой базы данных Neo4j. Установить Docker для macOS можно по этой
ссылке: https://hub.docker.com/editions/community/docker-ce-desktop-mac

Установка на Ubuntu также описана на официальном сайте: https://docs.docker.com/install/linux/docker-ce/ubuntu/

Для установки на свой любимый дистрибутив воспользуйтесь пакетным менеджером и инструкциями в
интернете.

### Образ с Neo4j

Для воркшопа подготовлен Docker образ Neo4j с загруженным датасетом. Скачайте его с Docker Hub:

```console
$ docker pull maksbotan/neo4j-fpure
```

И запустите:

```console
$ docker run -d -p 7474:7474 -p 7687:7687 maksbotan/neo4j-fpure
```

Веб-интерфейс к Neo4j доступен по адресу http://localhost:7474.

### Stack

Вам также понадобится компилятор Haskell и система сборки Stack. Установить Stack можно следующим
образом:

```console
$ curl -sSL https://get.haskellstack.org/ | sh
```

## Компиляция проекта

Склонируйте этот репозиторий и выполните в нем

```console
$ stack build
````

Эта команда скачает все нужные зависимости и скомпилирует код с задачами.

## Запуск примера

Репозиторий включает в себя полностью реализованный пример работы с Neo4j:
[`Sample.hs`](tasks/Sample.hs). Запустить его после компиляции можно так:

```console
$ stack exec -- neo4j-sample
```

## Структура файлов

* [docker/](docker/) - сборочные файлы для контейнера с базой данных
* `src/` - вспомогательный код
  * [`Config.hs`](src/Config.hs) - настройка доступа к локальной базе данных в Docker
  * [`Types.hs`](src/Types.hs) - определение типов данных `Person`, `Movie` и других
* `tasks/` - задачи
  * [`Sample.hs`](tasks/Sample.hs) - пример работы с Neo4j
  * [`Task1.hs`](tasks/Task1.hs), [`Task2.hs`](tasks/Task2.hs) - задачи, в которых нужно дописать
    код
* [`package.yaml`](package.yaml) - файл [hpack](https://github.com/sol/hpack)
* [`stack.yaml`](stack.yaml) - конфигурация Stack

В `package.yaml` описаны три executable:

* `neo4j-sample` - код из `Sample.hs`
* `neo4j-task1` - первая задача
* `neo4j-task2` - вторая задача

Запускаются они с помощью Stack:

```console
$ stack exec -- neo4j-sample
$ stack exec -- neo4j-task1
$ stack exec -- neo4j-task2
```

В коде каждой задачи оставлены пропуски в виде `undefined`, которые надо заполнить вам.

К каждой задаче уже подключены нужные зависимости, включая `lens` и, на всякий случай, `mtl`.

### Полезные ссылки

Документация по нужным модулям в `hasbolt` и `hasbolt-extras`:

* http://hackage.haskell.org/package/hasbolt-0.1.3.3/docs/Database-Bolt.html
* http://hackage.haskell.org/package/hasbolt-extras-0.0.0.16/docs/Database-Bolt-Extras-Graph.html
