RailsBridge BugMash Server Script
=================================

*(I need a longer name. taking submissions.)*

This is a script to take a debian box from ground zero to Rails Testing Machine. You will end up with MySQL, Postgres, Sqlite, Memcached and many rubies, as well as automated testing scripts.

Installation instructions
-------------------------

1. untar the installer to your home directory (or do git clone git://github.com/tsykoduk/Rails-Bugmasher.git)
2. Setup password-less sudo for your work account (not mandatory, but nice)
3. There really needs to be a step three - don't you think?
4. run the installer


What's it doing under the hood?
-------------------------------

It's updating your system, grabbing a whole bunch of new packages, installing them, configuring them, getting rvm, installing 3 or 4 rubies and pressing on.

Should I use this on my lovingly built workstation?
---------------------------------------------------

Um, **no**?

Seriously, we are running automated updates, upgrades, and core system package installs. Use a VM that you just installed linux onto.

Can I use this to build a production ready application server?
--------------------------------------------------------------

Again - **no**.

Well, possibly - but we have done zero hardening, and several of the packages are for development, not front line, battle hardened servers. This is a development tool.

Legal Stuff
---------------

This is fully copylefted. If you find some use for it, please do let me know.