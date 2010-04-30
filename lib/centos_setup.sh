echo -e "\n\n\n\n\ntested vs Centos 5.4. Any recient centos _should_ work\n\n\n\n\n"
#
# System Update
#

echo -e "Adding the EPEL repository"

sudo rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-3.noarch.rpm

sudo yum check-update -y
sudo yum upgrade -y

echo -e "If you installed any system updates, a reboot at this point would be advisable, do you wish to reboot?
         \n(type 'yes' or 'no') > "
read response
if [[ "yes" = "$response" ]] ; then
  sudo reboot
  echo -e "Pausing processing. do not touch your keyboard, we have control"
  read tmp_pause
else
  echo -e "Skipping reboot."
fi

echo -e "\ninstalling base system for building rubies"

sudo yum install -y git svn gcc gcc-c++ kernel-devel zlib libtool bison gdb strace gettext git rpm-build redhat-rpm-config zlib-devel openssl openssl-devel

echo -e "\ninstalling database engines"

sudo yum install mysql-server mysql-devel postgresql-server postgresql-devel memcached sqlite sqlite-devel

echo -e "Need to install a local version of Automake. Need RVM beforehand"

./lib/ruby_setup.sh

rvm package install automake

echo -e "Make sure that YOU DO NOT RUN THE ruby SET UP SCRIPT AGAIN"

