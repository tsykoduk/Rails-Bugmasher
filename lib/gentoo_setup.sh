echo -e "\nWOOOOT WOOOT WOOT not ready - no fair peeking\n\n\n\n\n\n\n"
echo -e "Following is EXPERMENTAL. Do not use unless you are a geek's geek.
         \n(type 'yes' or 'no') > "
read response
if [[ "yes" = "$response" ]] ; then
	echo -e "\nOk, you're the boss"
else
  exit 1
fi


echo -e "\n\n\n\n\nHold on, this might take a while......\n\n\n\n\n"

echo -e "Updating system"

## disabled for testing
## sudo emerge --sync 

sudo emerge --update --deep world

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

sudo emerge --quiet --keep-going dev-util/git dev-util/subversion sys-libs/zlib sys-devel/libtool sys-devel/bison sys-devel/gdb dev-util/strace sys-devel/gettext zlib-devel dev-libs/openssl net-misc/curl


echo -e "\ninstalling database engines"

sudo emerge --quiet --keep-going dev-db/mysql dev-db/postgresql dev-libs/libmemcached net-misc/memcached dev-db/sqlite

echo -e "\config tasks"
sudo emerge --config =dev-db/mysql-5.0.70-r1
sudo emerge --config =postgresql-8.1.11

echo -e "\nin your server, starting your processes..."

sudo rc-config restart mysql postgresql memcached


echo -e "\nadding autostarts for services"
sudo rc-config add mysql default
sudo rc-config add postgresql default
sudo rc-config add memcached default

