# Coah2

  [![Build Status](https://travis-ci.org/geta6/coah2.svg?branch=master)](https://travis-ci.org/geta6/coah2)

## Setup

```sh
make setup
make
```

## Components

system         | component
---------------|-----------
server         | nodejs
client         | require.js, almond.js, backbone.js and marionette.js
build assets   | grunt
test framework | mocha with supertest
process manage | self
process handle | SIGNAL interface
task manage    | make
deploy tool    | mina
debug env      | foreman

## Make Tasks

task name   | details
------------|---------
debug       | `start-dev` + `build-dev`
start       | start HTTP server, release current stdio (daemonize).
start-dev   | start HTTP server with current stdio for debug.
quit        | stop HTTP server after disconnect all workers (graceful).
stop        | stop HTTP server quickly.
reload      | restart all workers with interval, a.k.a. graceful reload.
restart     | restart master process for reload binary, has downtime.
build       | build one time for production with grunt.
build-dev   | build continuous for development with grunt.
test        | run test
setup       | setup modules (gem, npm, bower).

memo: cannot reload binary on the fly.

## Signal Operations

signal          | operation
----------------|-----------
SIGINT, SIGTERM | shutdown quickly.
SIGQUIT         | shutdown gracefully.
SIGWINCH        | restart all workers with interval.

memo: SIGWINCH triggerd on resize terminal window.

## Mina Interfaces

    bundle exec mina process:{build,test,start,stop,restart,reload}

