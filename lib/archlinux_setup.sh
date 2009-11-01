echo -e "Updating the System"

sudo pacman -Syu --noconfirm

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

sudo pacman -S --noconfirm git subversion gcc gcc-libs make kernel-headers zlib libtool bison gdb strace gettext openssl jdk jre 


echo -e "\ninstalling database engines"

sudo pacman -S --noconfirm install mysql libmysqlclient mysql-clients postgresq libpqxx postgresql-libs
l memcached sqlite-3

echo -e "\nmemcached is borked. known issue, and we're working on it..." 

