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

#you can add jruby if you want to - it is slow to install gems, and has some special requirements 

ruby_versions="${ruby_versions:-"1.8.6 1.8.7 1.9.1 ree"}"
rails_required_gems="rails rack rack-test mocha mysql postgres sqlite3-ruby memcached memcache-client bundler RedCloth multimap abstract"


#
# rvm, rubies and gems
#

echo -e "\nWe are going to replace your gemrc with the following line: \ngem: --no-rdoc --no-ri\n(If you have no clue what this means, it's more then likely ok)\nOk?(y/n)"
read response 
	if [[ "y" = "$response" ]] ; then
		echo "gem: --no-rdoc --no-ri" > ~/gemrc
		sudo mv ./gemrc /etc/
	else
		echo -e "\nFine. Skipping this step"
	fi

echo -e "\nInstalling and configuring rvm..."
cd ~ && git clone git://github.com/wayneeseguin/rvm.git temp_rvm && cd temp_rvm && ./install && cd ~ && rm -rf temp_rvm

echo "rvm_install_on_use_flag=1" > ~/.rvmrc

source ~/.bash_profile

echo -e "\nInstalling rubies and gems with rvm..."

for ruby in $ruby_versions
do
echo -e "\ninstalling '${ruby}'"
	rvm install ${ruby}
	echo "installing gems : '${rails_required_gems}'"
	rvm ${ruby}
	for gem in $rails_required_gems
	do
		echo -e "\n=============================\n"
		echo -e "\ninstalling ${gem}..."
		gem install ${gem}
	done
done

echo -e "\n\nWhat do you want to use as your default? (1.8.6 1.8.7 1.9.1 or ree)\n"
read response 

rvm use $response
	
	
echo -e "Rubies set up. begin wooting"
