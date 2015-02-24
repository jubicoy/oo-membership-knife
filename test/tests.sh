DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

oneTimeTearDown() {
    # Clear memberships
    rhc -k member remove --all -n test1d1 -l test1 -p test
    rhc -k member remove --all -n test1d2 -l test1 -p test

    rhc -k member remove --all -n test2d1 -l test2 -p test
    rhc -k member remove --all -n test2d2 -l test2 -p test
}

setUp() {
    # Clear memberships
    rhc -k member remove --all -n test1d1 -l test1 -p test
    rhc -k member remove --all -n test1d2 -l test1 -p test

    rhc -k member remove --all -n test2d1 -l test2 -p test
    rhc -k member remove --all -n test2d2 -l test2 -p test
}

assertContains() {
    msg=''
    if [ $# -eq 3 ]; then
        msg=$1
        shift
    else
        msg="'\${printed}' does not contain '\${pattern}'"
    fi
    printed=$1
    pattern=$2

    msg=`eval "echo \"${msg}\""`
    # cludge
    if [[ $printed =~ $pattern ]]; then
        assertTrue "${msg}" true
    else
        assertTrue "${msg}" false
    fi
}

assertDoesNotContain() {
    msg=''
    if [ $# -eq 3 ]; then
        msg=$1
        shift
    else
        msg="\"\${printed}\" contains \"\${pattern}\""
    fi
    printed=$1
    pattern=$2

    msg=`eval "echo \"${msg}\""`
    # cludge
    if [[ $printed =~ $pattern ]]; then
        assertTrue "${msg}" false
    else
        assertTrue "${msg}" true
    fi
}

testAddUserToSingle() {
    assertDoesNotContain "$(rhc -k member list -n test1d1 -l test1 -p test)" \
        'backup[ \t]*edit'
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "backup[ \t]*edit"

    $DIR/../oo-membership-knife -c add -l backup -d test1d1

    assertContains "$(rhc -k member list -n test1d1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "backup[ \t]*edit"
}

testAddTeamToSingle() {
    assertDoesNotContain "$(rhc -k member list -n test1d1 -l test1 -p test)" \
        "testteam[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "test2[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "test2[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -l test1 -p test)" \
        "testteam[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "test2[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "backup[ \t]*edit"

    $DIR/../oo-membership-knife -c add -t testteam -d test1d1

    assertContains "$(rhc -k member list -n test1d1 -l test1 -p test)" \
        "testteam[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "test2[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "test2[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -l test1 -p test)" \
        "testteam[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "test2[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "backup[ \t]*edit"
}

testAddUserToAll() {
    assertDoesNotContain "$(rhc -k member list -n test1d1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d1 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d1 -a a1 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d2 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d2 -a a2 -l test2 -p test)" \
        "backup[ \t]*edit"

    $DIR/../oo-membership-knife -c add-all -l backup

    assertContains "$(rhc -k member list -n test1d1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d1 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d1 -a a1 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d2 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d2 -a a2 -l test2 -p test)" \
        "backup[ \t]*edit"
}

testAddTeamToAll() {
    assertDoesNotContain "$(rhc -k member list -n test1d1 -l test1 -p test)" \
        "testteam[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "test2[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "test2[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -l test1 -p test)" \
        "testteam[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "test2[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d1 -l test2 -p test)" \
        "testteam[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d1 -a a1 -l test2 -p test)" \
        "test2[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d1 -a a1 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d2 -l test2 -p test)" \
        "testteam[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d2 -a a2 -l test2 -p test)" \
        "test2[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d2 -a a2 -l test2 -p test)" \
        "backup[ \t]*edit"

    $DIR/../oo-membership-knife -c add-all -t testteam

    assertContains "$(rhc -k member list -n test1d1 -l test1 -p test)" \
        "testteam[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "test2[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "test2[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d2 -l test1 -p test)" \
        "testteam[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "test2[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d1 -l test2 -p test)" \
        "testteam[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d1 -a a1 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d2 -l test2 -p test)" \
        "testteam[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d2 -a a2 -l test2 -p test)" \
        "backup[ \t]*edit"
}

testRemoveUserFromSingle() {
    # Prepare
    rhc -k member add -n test1d1 --role view backup -l test1 -p test

    assertContains "$(rhc -k member list -n test1d1 -l test1 -p test)" \
        'backup[ \t]*edit'
    assertContains "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "backup[ \t]*edit"

    $DIR/../oo-membership-knife -c remove -l backup -d test1d1

    assertDoesNotContain "$(rhc -k member list -n test1d1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "backup[ \t]*edit"
}

testRemoveTeamFromSingle() {
    # Prepare
    rhc -k member add -n test2d1 --role view testteam --type team -l test2 -p test
    rhc -k member add -n test2d2 --role view testteam --type team -l test2 -p test

    assertContains "$(rhc -k member list -n test2d1 -l test2 -p test)" \
        "testteam[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d1 -a a1 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d2 -l test2 -p test)" \
        "testteam[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d2 -a a2 -l test2 -p test)" \
        "backup[ \t]*edit"

    $DIR/../oo-membership-knife -c remove -t testteam -d test2d1

    assertDoesNotContain "$(rhc -k member list -n test2d1 -l test1 -p test)" \
        "testteam[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d1 -a a1 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d2 -l test2 -p test)" \
        "testteam[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d2 -a a2 -l test2 -p test)" \
        "backup[ \t]*edit"
}

testRemoveUserFromAll() {
    # Prepare
    rhc -k member add -n test1d1 --role view backup -l test1 -p test
    rhc -k member add -n test1d2 --role view backup -l test1 -p test
    rhc -k member add -n test2d1 --role view backup -l test2 -p test
    rhc -k member add -n test2d2 --role view backup -l test2 -p test

    assertContains "$(rhc -k member list -n test1d1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d1 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d1 -a a1 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d2 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d2 -a a2 -l test2 -p test)" \
        "backup[ \t]*edit"

    $DIR/../oo-membership-knife -c remove-all -l backup

    assertDoesNotContain "$(rhc -k member list -n test1d1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a1 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d1 -a a2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test1d2 -a a3 -l test1 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d1 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d1 -a a1 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d2 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d2 -a a2 -l test2 -p test)" \
        "backup[ \t]*edit"
}

testRemoveTeamFromAll() {
    # Prepare
    rhc -k member add -n test2d1 --role view testteam --type team -l test2 -p test
    rhc -k member add -n test2d2 --role view testteam --type team -l test2 -p test

    assertContains "$(rhc -k member list -n test2d1 -l test2 -p test)" \
        "testteam[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d1 -a a1 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d2 -l test2 -p test)" \
        "testteam[ \t]*edit"
    assertContains "$(rhc -k member list -n test2d2 -a a2 -l test2 -p test)" \
        "backup[ \t]*edit"

    $DIR/../oo-membership-knife -c remove-all -t testteam

    assertDoesNotContain "$(rhc -k member list -n test2d1 -l test2 -p test)" \
        "testteam[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d1 -a a1 -l test2 -p test)" \
        "backup[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d2 -l test2 -p test)" \
        "testteam[ \t]*edit"
    assertDoesNotContain "$(rhc -k member list -n test2d2 -a a2 -l test2 -p test)" \
        "backup[ \t]*edit"
}

. /usr/share/shunit2/shunit2
