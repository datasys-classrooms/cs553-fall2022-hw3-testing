### CS553 Cloud Computing Homework 3 Testing Repo
**Illinois Institute of Technology**  

**TAs**: 
* Alexandru Iulian Orhean (aorhean@hawk.iit.edu)  
* Lan Nguyen (lnguyen18@hawk.iit.edu)  

### How to run test scripts
In order to run the test scripts you will need to clone this repo in your homework repo:
```
$ cd <your homework repo directory>
$ git clone https://github.com/datasys-classrooms/cs553-fall2022-hw3-testing.git
```

You will need to copy the test data from the test repo to your repo:
```
cp cs553-fall2022-hw3-testing/test-data.txt test-data.txt
```

You can then run all the checks and tests by calling:
```
$ bash cs553-fall2022-hw3-testing/check-submission.sh all
$ bash cs553-fall2022-hw3-testing/test-submission.sh all
```

Or you can run an individual check or test by calling:
```
$ bash <path to cs553-fall2022-hw3-testing>/check-submission.sh <check number>
$ bash <path to cs553-fall2022-hw3-testing>/test-submission.sh <test number>
```