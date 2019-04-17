# Dockerfile with Neo4j

This directory contains `Dockerfile` with Neo4j set up for workshop: DB with sample dataset is
preloaded and password is set.

## Build

To build the image run

```console
$ docker build . -t neo4j-fpure
```

## Run

To run the resulting instance do

```console
$ docker run -d -p 7474:7474 -p 7687:7687 neo4j-fpure
```

This will setup web-interface at http://localhost:7474 and Bolt server at localhost:7687.

Username: `neo4j`

Password: `fpure`
