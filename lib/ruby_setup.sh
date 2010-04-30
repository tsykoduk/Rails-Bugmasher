# Install rvm and Ruby
#
#
# User configurable settings

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

echo -e "\n\ninstalling 1.8.7"
rvm install 1.8.7
rvm use 1.8.7 --default
rvm list
	
echo -e "\n\nRubies set up. begin wooting"

