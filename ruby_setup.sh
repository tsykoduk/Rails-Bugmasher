#
# Install rvm, rubies and gems
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
