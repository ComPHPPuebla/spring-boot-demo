#!/bin/bash
LINE=$'\n'
ERROR=""

COUNT=$(git --no-pager diff --name-only FETCH_HEAD $(git merge-base FETCH_HEAD master) | grep "^target" | wc -l)

if [ "${COUNT}" -gt 0 ]
then
    ERROR="${ERROR}* Do not commit your target directory${LINE}"
fi

COUNT=$(git --no-pager diff --name-only FETCH_HEAD $(git merge-base FETCH_HEAD master) | grep "^.idea" | wc -l)

if [ "${COUNT}" -gt 0 ]
then
    ERROR="${ERROR}* Do not commit your .idea directory${LINE}"
fi

COUNT=$(git --no-pager diff --name-only FETCH_HEAD $(git merge-base FETCH_HEAD master) | grep "^src/main/resources/application.properties" | wc -l)

if [ "${COUNT}" -gt 0 ]
then
    ERROR="${ERROR}* Do not commit your application.properties file${LINE}"
fi

COUNT=$(git --no-pager diff --name-only FETCH_HEAD $(git merge-base FETCH_HEAD master) | wc -l)
echo "${COUNT}"

if [ "${COUNT}" -gt 20 ]
then
    ERROR="${ERROR}* Your commit includes too many files: ${COUNT}${LINE}"
fi

if [ ! -z "$ERROR" ]
then
    >&2 echo "${ERROR}"
    exit 1
fi

exit 0
