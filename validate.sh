#!/bin/bash
LINE=$'\n'
ERROR=""

if [ -e target ] && [ -d target ]
then
    ERROR="${ERROR}* Do not commit your target directory${LINE}"
fi

if [ -e .idea ] && [ -d .idea ]
then
    ERROR="${ERROR}* Do not commit your .idea directory${LINE}"
fi

if [ -e src/main/resources/application.properties ]
then
    ERROR="${ERROR}* Do not commit your application.properties file${LINE}"
fi

COUNT=$(git --no-pager diff --name-only FETCH_HEAD $(git merge-base FETCH_HEAD master) | wc -l)
echo "${COUNT}"

if [ "${COUNT}" -gt 20 ]
then
    ERROR="${ERROR}* Your commit includes too many files."
fi

if [ ! -z "$ERROR" ]
then
    >&2 echo "${ERROR}"
    exit 1
fi

exit 0
