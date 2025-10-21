#!/bin/bash

error_exit() {
    echo "Error: $1" >&2
    echo "Usage: $0 DELIVERY" >&2
    echo "          DELIVERY is one of 'e0', 'ei', or 'ef'" >&2
    exit 1
}

[[ $# -ne 2 ]] && error_exit "argument expected"

DELIVERY=$1
GROUP=$2

./test-group.sh $DELIVERY $GROUP < /dev/null
# clean unnecessary files
rm -f logs/$DELIVERY/*.out 2>/dev/null
# git add logs/$DELIVERY/$GROUP.res.html logs/$DELIVERY/$GROUP.log.html || true
# git commit -am "Updated test results for group $GROUP."
