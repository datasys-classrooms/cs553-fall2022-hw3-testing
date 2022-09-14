#!/bin/bash

echoerr()
{
    echo "$@" >&2
}

get_data_number()
{
    local_num_data=$(cat test-data.txt | wc -l)
    echo $((1 + $RANDOM % $local_num_data))
}

get_seed_from_data()
{
    echo $(head -n $1 test-data.txt | tail -n 1 | cut -d ' ' -f1)
}

get_checksum_from_data()
{
    echo $(head -n $1 test-data.txt | tail -n 1 | cut -d ' ' -f2)
}

STATUS=0

TEST1()
{
    MSG="1. Test single precision 512x512 matrix multiplication with 1 thread ...            "
    if [ ! -f cpubench ]
    then
        echo "$MSG failed!"
        echo "*** cpubench binary is missing ***" 
        STATUS=2
    else
        data_number=$(get_data_number)
        seed=$(get_seed_from_data $data_number)
        checksum=$(get_checksum_from_data $data_number)
        ./cpubench $seed matrix single 512 1 &> cpubench.log
        local rc=$(cat cpubench.log | tail -n 1 | grep "checksum" | cut -d ' ' -f2)
        if [ "$rc" == "" ]
        then
            local rc=$(($checksum + 1))
        fi
        if [ $rc -eq $checksum ]
        then
            echo "$MSG passed!" 
        else
            echo "$MSG failed!"
            echo "*** Test 1 run log ***"
            echo "./cpubench $seed matrix single 512 1"
            cat cpubench.log
            echo "** Expected checksum = $checksum ***"
            STATUS=1
        fi
    fi
}

TEST2()
{
    MSG="2. Test double precision 512x512 matrix multiplication with 1 thread ...            "
    if [ ! -f cpubench ]
    then
        echo "$MSG failed!"
        echo "*** cpubench binary is missing ***" 
        STATUS=2
    else
        data_number=$(get_data_number)
        seed=$(get_seed_from_data $data_number)
        checksum=$(get_checksum_from_data $data_number)
        ./cpubench $seed matrix double 512 1 &> cpubench.log
        local rc=$(cat cpubench.log | tail -n 1 | grep "checksum" | cut -d ' ' -f2)
        if [ "$rc" == "" ]
        then
            local rc=$(($checksum + 1))
        fi
        if [ $rc -eq $checksum ]
        then
            echo "$MSG passed!" 
        else
            echo "$MSG failed!"
            echo "*** Test 2 run log ***"
            echo "./cpubench $seed matrix double 512 1"
            cat cpubench.log
            echo "*** Expected checksum = $checksum ***"
            STATUS=1
        fi
    fi
}

TEST3()
{
    MSG="3. Test single precision 512x512 matrix multiplication with 8 threads ...           "
    if [ ! -f cpubench ]
    then
        echo "$MSG failed!"
        echo "*** cpubench binary is missing ***" 
        STATUS=2
    else
        data_number=$(get_data_number)
        seed=$(get_seed_from_data $data_number)
        checksum=$(get_checksum_from_data $data_number)
        ./cpubench $seed matrix single 512 8 &> cpubench.log
        local rc=$(cat cpubench.log | tail -n 1 | grep "checksum" | cut -d ' ' -f2)
        if [ "$rc" == "" ]
        then
            local rc=$(($checksum + 1))
        fi
        if [ $rc -eq $checksum ]
        then
            echo "$MSG passed!" 
        else
            echo "$MSG failed!"
            echo "*** Test 3 run log ***"
            echo "./cpubench $seed matrix single 512 8"
            cat cpubench.log
            echo "*** Expected checksum = $checksum ***"
            STATUS=1
        fi
    fi
}

TEST4()
{
    MSG="4. Test double precision 512x512 matrix multiplication with 8 threads ...           "
    if [ ! -f cpubench ]
    then
        echo "$MSG failed!"
        echo "*** cpubench binary is missing ***" 
        STATUS=2
    else
        data_number=$(get_data_number)
        seed=$(get_seed_from_data $data_number)
        checksum=$(get_checksum_from_data $data_number)
        ./cpubench $seed matrix double 512 8 &> cpubench.log
        local rc=$(cat cpubench.log | tail -n 1 | grep "checksum" | cut -d ' ' -f2)
        if [ "$rc" == "" ]
        then
            local rc=$(($checksum + 1))
        fi
        if [ $rc -eq $checksum ]
        then
            echo "$MSG passed!" 
        else
            echo "$MSG failed!"
            echo "*** Test 4 run log ***"
            echo "./cpubench $seed matrix double 512 8"
            cat cpubench.log
            echo "*** Expected checksum = $checksum ***"
            STATUS=1
        fi
    fi
}
NUM_TESTS=4
HOW_TO_USE="HOW TO USE: bash .github/workflows/test-submission.sh [<check number> | list | all]"

if [ $# -ne 1 ]
then
    echoerr "$HOW_TO_USE"
    exit 1
fi

arg1=$1

if [ "$arg1" == "list" ]
then
    echo "List of available checks:"
    echo "1. Test single precision 512x512 matrix multiplication with 1 thread"
    echo "2. Test double precision 512x512 matrix multiplication with 1 thread"
    echo "3. Test single precision 512x512 matrix multiplication with 8 threads"
    echo "4. Test double precision 512x512 matrix multiplication with 8 threads"
    exit 0
fi

if [ "$arg1" == "all" ]
then
    for((i=1;i<=$NUM_TESTS;i++))
    do
        TEST$i
    done
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