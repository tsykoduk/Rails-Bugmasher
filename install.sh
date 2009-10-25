#! /bin/bash

cat <<-BeginMessage
Use this script to build a *nix system for testing rails, or to build a rails dev system

Copyleft 2009 by Greg Nokes

Built on the hypercool RVM

Version 0.0.1

Use at your own risk, yadda yadda yadda

Only the Debian and Rubies installer work so far.

do *NOT* run as root!!

*do* run in the home directory of a user for which you do not care

BeginMessage

#menu here

echo "Choose one of the following:"
echo "0 After Distro Run, Install Rubies"
echo "1 Install Archlinux Support (Not Done)"
echo "2 Install Centos Support (Not Done)"
echo "3 Install Debian/Ubuntu Support"
echo "4 Install Gentoo Support (Not Done)"
echo "5 Install Snow Lepoard Support (Not Done)"

read response 
case $response in
	[0]*)
		echo "Installing Rubies"
		./lib/ruby_rails_setup.sh
	;;
	[1]*)
		echo "Archlinux Support Not Implemtented. Sorry"
	;;
	[2]*)
		echo "Centos support not done yet. Sorry"
	;;
	[3]*)
		echo "Installing Debain Support"
		./lib/debian_setup.sh
	;;
	[4]*)
		echo "Gentoo Support Coming"
	;;
	[5]*)
		echo "Snow Lepoard Support soon"
	;;
esac

cat <<-HappyMessage

Notes:
	* Something pithy will be added here soon
	* http://www.youtube.com/watch?v=IhJQp-q1Y1s

HappyMessage

popd
exit 0