# Install rvm and Ruby
#
#
# User configurable settings
#
# let's make sure we are somewhere sane

cd ~
#
# Ok, let's move on
#

#you can add jruby if you want to

ruby_versions="${ruby_versions:-"1.8.6 1.8.7 1.9.1 ree"}"
rails_required_gems="rails rack rack-test mocha mysql postgres sqlite3-ruby memcached memcache-client bundler RedCloth multimap abstract"


#
# rvm, rubies and gems
#

echo -e "\nWe are going to replace your gemrc with the following line: \ngem: --no-rdoc --no-ri\nOk? (y/n)"
read response 
	if [[ "y" = "$response" ]] ; then
		echo "gem: --no-rdoc --no-ri" > ~/gemrc
		sudo mv ./gemrc /etc/
	else
		echo -e "\nOk. skipping step"
	fi

echo -e "\nInstalling and configuring rvm..."
cd "$user_src_dir" && git clone git://github.com/wayneeseguin/rvm.git ~/temp_rvm && ~/temp_rvm/install && rm -rf ~/temp_rvm
echo "rvm_install_on_use_flag=1" > ~/.rvmrc

source ~/.bash_profile

echo -e "\nInstalling rubies and gems with rvm..."

for ruby in $ruby_versions
do
echo -e "\ninstalling '${ruby}'"
	rvm ${ruby} install
	echo "installing gems : '${rails_required_gems}'"
	for gem in $rails_required_gems
	do
		echo -e "\n=============================\n"
		echo -e "\ninstalling ${gem}..."
		rvm ${ruby} gem install ${gem}
	done
done

mkdir ~/projects

echo -e "\nFetching edge rails"
echo
cd ~/projects && git clone git://github.com/rails/rails.git rails && cd rails && git branch --track 2-3-stable origin/2-3-stable && cd actionpack

for ruby in $ruby_versions
do
echo -e "\nbunding gems for ${ruby}"
	rvm use ${ruby}
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
