#!/bin/sh

status=0

if [[ $(< test.txt) == "KO" ]]; then
    # send e-mail
    status=125
fi

exit $status
