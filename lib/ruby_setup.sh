# Install rvm and Ruby
#
#
# User configurable settings


ruby_versions="${ruby_versions:-"1.8.7 1.9.2-head"}"

#Deprecated with Rails3
#rails_required_gems="rails rack rack-test mocha mysql postgres sqlite3-ruby memcached memcache-client bundler RedCloth multimap abstract"

# let's make sure we are somewhere sane

cd ~

#
# Ok, let's move on and install rvm, rubies and gems
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

echo "if [[ -s \"$HOME/.rvm/scripts/rvm\" ]]  ; then source \"$HOME/.rvm/scripts/rvm\" ; fi" >> ~/.bash_profile

source ~/.bash_profile

for ruby in $ruby_versions
do
  echo -e "\n\ninstalling '${ruby}'"
	rvm install ${ruby}
	echo "installing gems : '${rails_required_gems}'"
	rvm ${ruby}
done

	
echo -e "\n\nRubies set up. begin wooting"

echo -e "\nGetting Jiggy with Rails"

mkdir ~/projects

cd ~/projects 

# Switch to 1.9.2-head and gemset rails3, create if it doesn't exist. 
rvm --create use 1.9.2-head@rails3

# Download the gems(et) file for rails3 beta 3:
curl -L http://rvm.beginrescueend.com/gemsets/rails3b3.gems -o rails3b3.gems 

# Load the gems(et) file into the current gem environment.
rvm gemset import rails3b3.gems

# Check to see we now have Rails 3.0.0 beta3
rails --version
