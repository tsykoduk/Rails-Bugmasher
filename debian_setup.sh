#! /bin/bash

pushd ~

cat <<-BeginMessage
Use this script to build a Debian Linux system for testing rails, or to build a rails dev system

Copyleft 2009 by Greg Nokes

Built on the hypercool RVM

Version 0.0.1

Use at your own risk, yadda yadda yadda
tested vs Ubuntu Karmic. Any recient debian _should_ work
centos not so much

do *NOT* run as root!!

Now bringing the base system up to date...
BeginMessage

#
# System Update
#
sudo aptitude update
sudo aptitude safe-upgrade -y
sudo aptitude dist-upgrade -y

#
# System Libraries
#
echo -e "\nNow installing rails test suite required system libraries..."
sudo aptitude install -y sudo build-essential git-core git-svn subversion ruby-dev mysql-server mysql-client sqlite3 nginx ssh postgresql memcached rake libmysqlclient-dev libpq-dev libsqlite3-dev curl wget sun-java6-jdk libreadline5-dev libssl-dev bison libopenssl-ruby zlib1g zlib1g-dev libxml2 libxml2-dev libxslt-dev locate libssl-dev openssl

sudo /etc/init.d/mysql restart
sudo /etc/init.d/postgresql-8.4 restart
sudo /etc/init.d/memcached restart
sudo /etc/init.d/nginx restart

echo -e "If you installed any system updates, a reboot at this point would be advisable, do you wish to reboot?\n(type 'yes' or 'no')> "
read response
if [[ "yes" = "$response" ]] ; then
  sudo reboot
  read tmp_pause
else
  echo -e "Skipping reboot."
fi

#
# User configurable settings
#
user_bin_dir="${user_bin_dir:-$user_bin_dir}"
user_src_dir="${user_src_dir:-.src}"
user_project_dir="${user_project_dir:-projects}"
rails_test_command_prefix="${test_prefix:-"rails_test"}"
ruby_versions="${ruby_versions:-"1.8.6,1.8.7,1.9.1,jruby,ree,rbx"}"
rails_required_gems="rails rack rack-test cucumber mocha rspec rspec-rails mysql postgres sqlite3-ruby memcached memcache-client builder bundler mongrel mongrel_cluster passenger thin polyglot test-unit treetop erubis term-ansicolor eventmachine diff-lcs daemons shoulda"

mkdir -p "${user_bin_dir}" "${user_src_dir}" "${user_project_dir}"

echo "PATH=${PATH}:${user_bin_dir} ; export PATH" >> ~/.bash_profile

#
# rvm, rubies and gems
#

sudo echo "gem: --no-rdoc --no-ri" > /etc/gemrc

echo -e "\nInstalling and configuring rvm..."
cd "$user_src_dir" && git clone git://github.com/wayneeseguin/rvm.git && cd rvm && ./install
echo "rvm_install_on_use_flag=1" > ~/.rvmrc

source ~/.bash_profile

echo -e "\nInstalling rubies and gems with rvm..."
rvm "${ruby_versions}" install
rvm "${ruby_versions}" gem install "${rails_required_gems}"

echo -e "\nFetching edge rails into the project directory '${user_project_dir}'"
cd "$user_project_dir" && git clone git://github.com/rails/rails.git rails && cd rails/actionpack && gem bundle

echo "Fetching Cinabox into the project directory ''${user_project_dir}'"
cd "$user_project_dir" && git clone git://github.com/thewoolleyman/cinabox.git cinabox

for type in json yaml verbose ; do
  echo -e "Creating ${test_prefix}_${type} script."

  echo -e "# /bin/bash\nsource ~/.rvm/scripts/rvm;cd $user_project_dir/rails && rvm rake test" > "${user_bin_dir}/${test_prefix}_verbose"

  chmod 700 "${user_bin_dir}/${test_prefix}_${type}"
done

cat <<-HappyMessage

Notes:

  * To run the rails test suite against all installed rubies simply run either ${test_prefix}_json or ${test_prefix}_verbose or ${test_prefix}_yaml
  * The verbose tester runs the standard tests vs the rails in $user_project_dir with all installed rubies
  * If you want to just test vs one version of ruby, just rvm use that version, and then run rake test
  * This script does not setup cinabox - if you want cinabox setup you will need to do it yourself.

all done.... happy bugmashing!!!

HappyMessage

popd
exit 0
