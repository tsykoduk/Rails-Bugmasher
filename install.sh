#! /bin/bash

clear
echo "environment checks"

user="$(whoami)"
if [[ "root" = "$user" ]] ; then
  echo -e "root user support is not yet implemented. Please log in as a normal user"
  exit 1
fi

clear

cat <<-BeginMessage
Use this script to build a *nix system for testing rails, or to build a rails dev system

Copyleft 2009 by Greg Nokes

Built on the hypercool RVM

Version 0.0.1

Use at your own risk, yadda yadda yadda

Only the Debian and Rubies installer work so far.

*do* run in the home directory of a user for which you do not care

BeginMessage

#menu here

while :
	do

		echo -e "Choose one of the following: \n0 After Distro Run, Install Rubies \n1 Install Archlinux Support (Not Done) \n2 Install Centos Support (Not Done) \n4 Install Gentoo Support (Not Done) \n5 Install Snow Lepoard Support (Not Done) \nq Quit\n"


		read response 
		case $response in
			[0]*)
			echo -e "\nInstalling Rubies"
				./lib/ruby_rails_setup.sh
			;;
			[1]*)
			echo -e "\nArchlinux Support Not Implemtented. Sorry"
			;;
			[2]*)
			echo -e "\nCentos support not done yet. Sorry"
			;;
			[3]*)
			echo -e "\nInstalling Debain Support"
				./lib/debian_setup.sh

			;;
			[4]*)
			echo -e "\nGentoo Support Coming"
			;;
			[5]*)
			echo -e "\nSnow Lepoard Support soon"
			;;
			[q]*)
				clear
				echo -e "\nHappy Bugmashing!\n"
				cat <<-HappyMessage

				Notes:
				* Something pithy will be added here soon
				* http://www.youtube.com/watch?v=IhJQp-q1Y1s

				HappyMessage

				exit 0
		esac
	done	