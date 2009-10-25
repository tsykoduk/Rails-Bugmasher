#!/usr/bin/env bash
source ~/.rvm/scripts/rvm

## Useage
## json_tester.sh ruby ruby2 ruby3

for ruby in $@
	do
		cd ./rails
		rvm $ruby --json rake test
		echo
		cd ..
done
