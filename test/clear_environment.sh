function get_apps() {
    rhc apps --mine -l $1 -p $2|grep @|sed -e '/^[ \t-].*/d' -e '/^$/d' -e 's/\([a-zA-Z0-9]\) @.*/\1/'
}

function delete_app() {
    printf "yes\n"|rhc delete-app $3 -l $1 -p $2
}

function delete_all() {
    for app in $(get_apps $1 $2)
    do
        delete_app $1 $2 $app
    done
}

# Delete all stray apps
delete_all test1 test
delete_all test2 test

# Delete domains
oo-admin-ctl-domain -l test1 -n test1d1 -c delete
oo-admin-ctl-domain -l test1 -n test1d2 -c delete

oo-admin-ctl-domain -l test2 -n test2d1 -c delete
