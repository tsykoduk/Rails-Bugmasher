echo -e "tested vs Ubuntu Karmic. Any recient debian _should_ work"
echo 
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
sudo aptitude install -y sudo build-essential git-core git-svn subversion ruby-dev mysql-server mysql-client sqlite3 nginx ssh postgresql memcached rake libmysqlclient-dev libpq-dev libsqlite3-dev curl wget sun-java6-jdk libreadline5-dev libssl-dev bison libopenssl-ruby libz-dev zlib1g zlib1g-dev libxml2 libxml2-dev libxslt-dev locate libssl-dev openssl

sudo /etc/init.d/mysql restart
sudo /etc/init.d/postgresql-8.4 restart
sudo /etc/init.d/memcached restart
sudo /etc/init.d/nginx restart

echo -e "If you installed any system updates, a reboot at this point would be advisable, do you wish to reboot?\n(type 'yes' or 'no') > "
read response
if [[ "yes" = "$response" ]] ; then
  sudo reboot
  echo -e "Pausing processing. do not touch your keyboard, we have control"
  read tmp_pause
else
  echo -e "Skipping reboot."
fi



