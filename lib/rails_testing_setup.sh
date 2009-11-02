##
#setting up rails for testing
##

echo -e "\ngetting rails ready for bugmashing"

mkdir ~/projects

echo -e "\nFetching edge rails"
echo
cd ~/projects && git clone git://github.com/rails/rails.git rails && cd rails && git branch --track 2-3-stable origin/2-3-stable && cd actionpack

for ruby in $ruby_versions
do
echo -e "\nbunding gems for ${ruby}"
	rvm ${ruby}
	gem bundle
done


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