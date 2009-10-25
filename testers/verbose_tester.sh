#!/usr/bin/env bash
source ~/.rvm/scripts/rvm

## Useage
## verbose_tester.sh ruby ruby2 ruby3

for ruby in $@
	do
		cd ./rails
		rvm $ruby rake test
		echo
		cd ..
done
