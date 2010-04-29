##
#setting up rails for testing
##

source ~/.bash_profile

ruby_versions="${ruby_versions:-"1.9.2-head"}"

echo -e "\ngetting rails ready for bugmashing"

mkdir ~/projects

echo -e "\nFetching edge rails"
echo
cd ~/projects && git clone git://github.com/rails/rails.git rails && cd rails && git branch

echo -e "\nInstalling rubies and gems with rvm..."

cd ~/projects 

# Switch to 1.9.2-head and gemset rails3, create if it doesn't exist. 
rvm --create use 1.9.2-head@rails3

# Download the gems(et) file for rails3 beta 3:
curl -L http://rvm.beginrescueend.com/gemsets/rails3b3.gems -o rails3b3.gems 

# Load the gems(et) file into the current gem environment.
rvm gemset import rails3b3.gems

# Check to see we now have Rails 3.0.0 beta3
rails --version

echo -e "\nFetching Cinabox"
echo
cd ~/projects && git clone git://github.com/thewoolleyman/cinabox.git cinabox

cp ~/Rails-Bugmasher/testers/* ~/projects/


cat <<-HappyMessage

Notes:

  * To run the rails test suite against all installed rubies simply run either ~/projects/json_tester.sh, yaml_tester.sh or verbose_tester.sh
  * The verbose tester runs the standard tests vs the rails in ~/project/rails with all installed rubies
  * If you want to just test vs one version of ruby, just rvm use that version, and then run rake test
  * This script does not setup cinabox - if you want cinabox setup you will need to do it yourself.

all done.... happy bugmashing!!!

HappyMessage

echo -e "\npause"
read pause