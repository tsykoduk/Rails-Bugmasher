#!/usr/bin/env bash
source ~/.rvm/scripts/rvm

## Useage
## yaml_tester.sh ruby ruby2 ruby3

for ruby in $@
	do
		cd ./rails
		rvm $ruby --yaml rake test
		echo
		cd ..
done
