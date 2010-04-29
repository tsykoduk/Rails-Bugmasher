#! /bin/bash

clear
echo "environment checks"

# let's make sure we are somewhere sane
cd ~


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

Version 0.9.9.9.9 <-- SEE MA, I's MAKIN PROGRESS

Use at your own risk, yadda yadda yadda, *do* run in the home directory of a user for which you *do* *not* *care*
Works best with passwordless sudo

BeginMessage


while :
	do

cat <<-menu 
Choose one of the following
=-=-=-=-=-=-=-=-=-=-=-=-=-= 
0 Run the whole shebang 
1 Install Archlinux 
2 Install Centos Support
3 Install Debian Support
4 Install Gentoo Support
5 Install Mac Support (EXPERIMENTAL)
6 Install Rubies
7 Install Rails Testing Enviroment
q Quit

menu
		read response 
		case $response in
			[0]*)
			echo -e "\nWhich Distro? Arch: 0, Centos: 1, Debian: 2, Gentoo: 3, Mac: 4"
			read answer
			case $answer in
				[0]*)
					./lib/archlinux_setup.sh && ./lib/ruby_setup.sh && ./lib/rails_testing_setup.sh
				;;
				[1]*)
					./lib/centos_setup.sh && ./lib/ruby_setup.sh && ./lib/rails_testing_setup.sh
				;;	
				[2]*)
					./lib/debian_setup.sh && ./lib/ruby_setup.sh && ./lib/rails_testing_setup.sh
				;;		
				[3]*)
					./lib/gentoo_setup.sh && ./lib/ruby_setup.sh && ./lib/rails_testing_setup.sh
				;;
				[4]*)
					./lib/OS_10.6_setup.sh && ./lib/ruby_setup.sh && ./lib/rails_testing_setup.sh
				;;
			esac
			;;
			[1]*)
			echo -e "\nInstalling Archlinux Support"
				./lib/archlinux_setup.sh
			;;
			[2]*)
			echo -e "\nInstalling Centos support"
				lib/centos_setup.sh
			;;
			[3]*)
			echo -e "\nInstalling Debain Support"
				./lib/debian_setup.sh

			;;
			[4]*)
			echo -e "\nInstalling Gentoo Support"
				./lib/gentoo_setup.sh
			;;
			[5]*)
			echo -e "\nMac Support"
				./lib/OS_10.6_setup.sh
			;;
			[6]*)
			echo -e "\nInstalling Rubies"
				./lib/ruby_setup.sh
			;;
			[7]*)
			echo -e "\nInstalling bugmashing rails enviroment"
				./lib/rails_testing_setup.sh
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