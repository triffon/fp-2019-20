#!/bin/bash

BOLD='\033[1m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NO_FORMAT='\033[0m'

PASSED=0
FAILED=0

while read test; do
    echo -e "${BOLD}Running tests in ${test}${NO_FORMAT}"
    racket -r $test &&
        let PASSED=PASSED+1 ||
        let FAILED=FAILED+1
    echo
done < <(find . -type f -name '*.scm')

TOTAL=$(expr "${PASSED}" + "${FAILED}")

if [ "${FAILED}" == 0 ]; then
    RED=$GREEN
fi

echo -e """${BOLD}Ran ${TOTAL} test suites: \
${GREEN}${PASSED} passed${NO_FORMAT} and \
${RED}${FAILED} failed${NO_FORMAT}."""
