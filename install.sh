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

cat <<-menu 
Choose one of the following
=-=-=-=-=-=-=-=-=-=-=-=-=-= 
0 Run the whole shebang 
1 Install Archlinux Support (Not Done)
2 Install Centos Support
3 Install Debian Support
4 Install Gentoo Support (Not Done)
5 Install Mac Support (EXPERMENTAL)
6 Install Rubies
7 Install Rails Testing Enviroment
q Quit

menu
		read response 
		case $response in
			[0]*)
			echo -e "\nWhich Distro? (A/C/D/G/M) :"
			read answer
			case $answer in
				[A]*)
				./lib/archlinux_setup.sh && ./lib/ruby_setup.sh && ./lib/rails_testing_setup.sh
				;;
				[C]*)
				./lib/centos_setup.sh && ./lib/ruby_setup.sh && ./lib/rails_testing_setup.sh
				;;	
				[D]*)
				./lib/debian_setup.sh && ./lib/ruby_setup.sh && ./lib/rails_testing_setup.sh
				;;		
				[G]*)
				./lib/gentoo_setup.sh && ./lib/ruby_setup.sh && ./lib/rails_testing_setup.sh
				;;
				[M]*)
				./lib/OS_10.6_setup.sh && ./lib/ruby_setup.sh && ./lib/rails_testing_setup.sh
				;;
			esac
			;;
			[1]*)
			echo -e "\nArchlinux Support Not Implemtented. Sorry"
			;;
			[2]*)
			echo -e "\nCentos support"
				./lib/centos_setup.sh
			;;
			[3]*)
			echo -e "\nInstalling Debain Support"
				./lib/debian_setup.sh

			;;
			[4]*)
			echo -e "\nGentoo Support Coming"
			;;
			[5]*)
			echo -e "\nMac Support"
				./lib/OS_10.6_setup.sh
			;;
			[6]*)
			echo -e "\nInstalling Rubies"
				./lib/ruby_rails_setup.sh
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