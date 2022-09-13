#!/bin/bash

echoerr()
{
    echo "$@" >&2
}

STATUS=0

TEST1()
{
    MSG="1. Check to see if the README is updated ...         "
    if [ ! -f README.md ]
    then
        echo "$MSG failed!"
        STATUS=2
    else
        local rc=$(cat README.md | grep "please-write" | wc -l)
        if [ $rc -eq 0 ]
        then
            echo "$MSG passed!"
        else
            echo "$MSG failed!"
            STATUS=1
        fi
    fi
}

TEST2()
{
    MSG="2. Check to see if the report is uploaded ...        "
    if [ ! -f hw3-report.pdf ]
    then
        echo "$MSG failed!"
        STATUS=2
    else
        local rc=$(ls -l hw3-report.pdf | tr -s ' ' | cut -d ' ' -f5)
        if [ $rc -ne 3653 ]
        then
            echo "$MSG passed!" 
        else
            echo "$MSG failed!"
            STATUS=1
        fi
    fi
}

NUM_TESTS=2
HOW_TO_USE="HOW TO USE: bash .github/workflows/check-submission.sh [<check number> | list | all]"

if [ $# -ne 1 ]
then
    echoerr "$HOW_TO_USE"
    exit 1
fi

arg1=$1

if [ "$arg1" == "list" ]
then
    echo "List of available checks:"
    echo "1. Check to see if the README is updated"
    echo "2. Check to see if the report is uploaded"
    exit 0
fi

if [ "$arg1" == "all" ]
then
    TEST1
    TEST2
    if [ $STATUS -ne 0 ]
    then
        exit 1
    fi
    exit 0
fi

if [ $arg1 -eq $arg1 ]
then
    TEST$arg1
    if [ $STATUS -ne 0 ]
    then
        exit 1
    fi
else
    echoerr "$HOW_TO_USE"
    exit 2
fi

exit 0