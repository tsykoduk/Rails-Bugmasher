#! /bin/bash

#######
echo "Use this script to build a Debian system for testing rails, or to build a rails dev system"
echo "Copyleft 2009 by Greg Nokes"
echo 
echo "Version 0.1"
echo "Use at your own risk, yadda yadda yadda"
echo "tested vs Ubuntu Karmic. Any recient debian _should_ work"
echo "centos not so much"
echo 
echo "it's a lot easier if you have passwordless sudo set up "
echo
echo
echo "do not run as root!!"
echo
echo
echo "Press any enter to start after you have read the above..."
read start
echo 
echo "Let's start with an up to date system"

sudo aptitude update
sudo aptitude safe-upgrade -y
sudo aptitude dist-upgrade -y

echo 
echo "We need to install some basic stuff"

sudo aptitude install -y sudo build-essential git-core git-svn subversion  mysql-server mysql-client sqlite3 nginx ssh postgresql memcached rake libmysqlclient-dev libpq-dev libsqlite3-dev curl wget sun-java6-jdk libreadline5-dev libssl-dev bison 

#packages no longer needed because of RVM: ruby ruby-dev rubyGEMS libopenssl-ruby

sudo /etc/init.d/mysql restart
sudo /etc/init.d/postgresql-8.4 restart
sudo /etc/init.d/memcached restart
sudo /etc/init.d/nginx restart

echo "If you installed updates, a reboot at this point would not be unwarrented."
# TODO: this appears to be borked. Need to fix
# echo "Reboot? [yes/no] "
# read REBOOT

# if (($REBOOT == "yes")); then
#	echo "rebooting system"
#	sudo reboot
# else
#	echo "skipping reboot"
# fi

echo 
echo "We need to install some basic ruby stuff"

GEMS="rails rack rack-test mocha cucumber mysql postgres sqlite3-ruby memcached memcache-client builder bundler rvm mongrel mongrel_cluster passenger polyglot test-unit thin rspec rspec-rails treetop erubis term-ansicolor polyglot eventmachine diff-lcs daemons thoughbot-shoulda"

# removing system rubies.
# sudo gem install --no-rdoc --no-ri ${GEMS}

echo
echo "Install lots of rubies"

git clone git://github.com/wayneeseguin/rvm.git && cd rvm && ./install

cd ~

source ~/.rvm/scripts/rvm

echo
echo "Install ruby 1.8.6."
rvm install 1.8.6 && rvm 1.8.6 gem install --no-rdoc --no-ri ${GEMS}

echo
echo "Install ruby 1.8.7."
rvm install 1.8.7 && rvm 1.8.7 gem install --no-rdoc --no-ri ${GEMS}

echo
echo "Install ruby 1.9.1."
rvm install 1.9.1 && rvm 1.9.1 gem install --no-rdoc --no-ri ${GEMS}

echo
echo "Install jruby"
rvm install jruby && rvm jruby gem install --no-rdoc --no-ri ${GEMS}

echo
echo "Install ruby enterprise"
rvm install ree && rvm ree gem install --no-rdoc --no-ri ${GEMS}

echo
echo "Install ruby Rubinus"
rvm install rbx
rvm rbx gem install --no-rdoc --no-ri ${GEMS}

echo "Let's start setting up the real stuff we need"
echo "we work out of the ~/code directory"
mkdir ~/code

echo "OK. get edge rails"

cd ~/code
git clone git://github.com/rails/rails.git rails
cd rails && cd actionpack && gem bundle

cd ~/code
echo "OK, get Cinabox"
git clone git://github.com/thewoolleyman/cinabox.git cinabox
echo "we don't setup cinabox - if you want it, do it"

echo
echo "Building our test script"
cd ~

echo "#! /bin/bash
if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi
cd ~/code/rails
rvm 1.8.6,1.8.7,ree,jruby,1.9.1,rbx --json rake test
cd ~
" > json_test_rails.sh && chmod 700 json_test_rails.sh

echo "the json_test_rails file will test the rails in ~/code with json style output vs all installed rubies"

echo "# /bin/bash
if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi
cd ~/code/rails
rvm 1.8.6,1.8.7,ree,jruby,1.9.1,rbx  rake test
cd ~
" > verbose_test_rails.sh && chmod 700 verbose_test_rails.sh

echo
echo "the verbose tester runs the standard tests vs the rails in ~/code with all installed rubies"
echo "If you want to just test vs one version of ruby, just rvm use that version, and then run rake test"

echo
echo "all done.... happy bugmashing"
