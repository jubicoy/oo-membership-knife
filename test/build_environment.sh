# Create users
oo-admin-ctl-user -l test1 -c
oo-admin-ctl-user -l test2 -c
oo-admin-ctl-user -l test3 -c
oo-admin-ctl-user -l backup -c
htpasswd -b /etc/openshift/htpasswd test1 test
htpasswd -b /etc/openshift/htpasswd test2 test
htpasswd -b /etc/openshift/htpasswd test3 test
htpasswd -b /etc/openshift/htpasswd backup test

# Create a team
oo-admin-ctl-user -l test2 --setmaxteams 1
rhc -k team create -t testteam -l test2 -p test
rhc -k add-member backup -t testteam -l test2 -p test

# Create domains
oo-admin-ctl-domain -l test1 -n test1d1 -c create
oo-admin-ctl-domain -l test1 -n test1d2 -c create

oo-admin-ctl-domain -l test2 -n test2d1 -c create
oo-admin-ctl-domain -l test2 -n test2d2 -c create

# Create apps
printf "no\n"|rhc -k create-app a1 php-5.4 -n test1d1 -l test1 -p test
printf "no\n"|rhc -k create-app a2 php-5.4 -n test1d1 -l test1 -p test
printf "no\n"|rhc -k create-app a3 php-5.4 -n test1d2 -l test1 -p test

printf "no\n"|rhc -k create-app a1 php-5.4 -n test2d1 -l test2 -p test
printf "no\n"|rhc -k create-app a2 php-5.4 -n test2d2 -l test2 -p test

# Do rhc setup to reduce amount of stderr output
printf "\ntest1\ntest\nno\nno\n"|rhc -k setup
