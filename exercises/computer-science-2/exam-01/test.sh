#!/usr/bin/env bash

if [ $# -lt 1 ]; then
        echo 'Usage: ./test.sh <filepath> [<variant>]'
        echo '  where <variant> := a | b | c'
        echo '  if not given, <variant> is equal to the name of the parent dir of <filepath>'
        echo 'Examples:'
        echo '  $ ./test.sh ../exam01/specCS/a/fn81858.rkt'
        echo '    runs tests for variant `a` on `fn81858.rkt`'
        echo '  $ ./test.sh ../exam01/fn81858.rkt c'
        echo '    runs tests for variant `c` on `fn81858.rkt`'
        exit 1
fi

parent=${1%/*}
variant=${2:-${parent##*/}}

racket <(echo '#lang racket'
         cat $1 describe.rkt ${variant:?}-tests.rkt \
           | grep -vE '#lang racket|\(require "describe.rkt"\)')
