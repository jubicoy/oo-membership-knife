sudo -i
mkdir ~/.openshift
yum install -y epel-release
cat <<EOF > ~/.openshift/oo-install-cfg.yml
---
Deployment:
    Hosts:
      - load_balancer: N
        mongodb_admin_user: admin
        broker_session_secret: nlznNYOgJ0T0Z1gIvJ1LQ
        ip_addr: 10.0.2.15
        user: root
        broker_auth_salt: Lr8eDJq9n9zWAKVvg97myg
        mongodb_broker_password: cbfMjcnE42uhCx4NKpM4tw
        ip_interface: eth0
        mcollective_password: Vv4LZrKBttorSIgrE5Dcmw
        mcollective_user: mcollective
        openshift_password: rmbAxeMqs7KGVxtv71izA
        named_ip_addr: 10.0.2.15
        broker_auth_priv_key: |
            -----BEGIN RSA PRIVATE KEY-----
            MIIEpAIBAAKCAQEA0MPSLN/DIUvry2c/mV+Q4/1pndiVFoHxQ1OdhNbdkA2wDZvN
            x8FXTJLFPNN3AAeGfj45z+Y4gvhFzHR+JGCRmTToFnYNiw/xX0TkIlD3VMpSoSgZ
            ZTRr8U/+4bTU9YToQS4p1t68FKuUtQNyxjS/xeobn6KG/Z2FZ/VyKe6lcvXDFkEy
            eUWhJ+aH0HZwt7u2VFbNHZtLyDbB8o6Sp9jpMW4wqcxvCPPERetxq8YX8ZRDzzIi
            rGd9X5OS8Y67tQX+tFbasfs3huhXFnjYe9GlPVw3gTEONrCIrKeaC+O/nixXnRDZ
            0oG8kjHu6VngAIu7nTxuuWUSvKwJ0ugMTnl8WwIDAQABAoIBACsJ49+adfj8VO1H
            KOZuvEk0ajy/dOUB/wI5T8UeIula2QvFLiRbaKsBqyYCFotsAb8vBu4kcUwW8RTY
            g1Tuj7W9IYfX6KzdqY5RfpLQjFzvpR9STAIAT6ydKFfR1wGS1+rwIHIK002TngG/
            Zz8TiuG7hNxhPmE0w1cOU+3vJC7RuoUjj8O0Djh8UwNVUzWlCBwVOOvMuz9xDuYx
            yd9lNtdyTRb2b+fMa69hahOQLvnEuQk4+rwjoigH+Oku+S4hmm9GCHoqe+DUlhY1
            Y6srbRn0tWjK2QS+aDBDaKcqA/L1TXt8umb5guGcDMMyUKFRLNE48YxnfWGwbrHl
            +lgsMfkCgYEA6lfhbW7aM1lLGZvwLhtsTzB2xO7vwSQ9mMnXWlQkB8E52GzXGFU0
            VnSvTcRx1HeRzMfQ8NxWZYY9PjlZ2FrbTvB3z/SYxyKoZHjvrkhD2ZldcSjS+VW4
            bntdwxv2C0VQs/bISuIFkB1+viRG9ZDPQbjeeTVqCyLpOdGtYW3RUw0CgYEA5A7O
            BvRBI7ZEqQsxiRiQPvgedsdRY2p2NT4muZVghZF0ZWbSiNoNsSkclX6VEqZVZufQ
            E4hJXJjRh2Hda1/fweGcKXMvz3bdzRWPMUb0UL1emrzI1eLRZNBq2QeP+AwPEsy5
            VgutJ95G4SDy74V5BTmAtpC2bL03H8SCMJZfUwcCgYBnqSQgwk5nNHKSC3a9Dohk
            py2Cg6cuqpdMxMwsOtgNTh4GbG7hZp9WNxtsrR8lOxcVnLYCNZVKJ41jvv7NQ7OL
            QbfeF3aVb/FJMG3ljDXnRX4eFk7s2ExTIuMg8XdvGORQFzQWW9DWJRXxih6RddMY
            YWyX9VbJQlIkr2mglXFo6QKBgQCDUYcO+AyeLLECicB/Sdade6/HA2R5E293nw8b
            Y8lNgAD+9qMaTD0AG0UrS9U5BPA+LhNhe+OKXzCffRnLX0xvzqJmN756/t4e3mAy
            psG90B0uirA2gMHEBELSL4mV8hOn5px90IFnaJV1wsxAYaHbAU59UXzJxnZ8Y2H3
            6k5/dwKBgQCwcN62++2U+vjle87/tX/RMtrBcV3UhWUth23u8vLwYtuxOOsX8WJH
            1RARIt68CFSwJz+9BIbZWC+Sf2E6qTWmuVkuZltrGsoywuZq+WYiehluokMgpA86
            vExnSY9rvzgnsf4zu4HCMCkyhSnRfWhn+hZ2lM3njrKVSFN6GtP+HQ==
            -----END RSA PRIVATE KEY-----
        console_session_secret: 0fudF9nsqhMZDR6biDtP6A
        openshift_user: demo
        mongodb_broker_user: openshift
        state: new
        mongodb_admin_password: KUZAZZYi7RAQGVy9NvRtcw
        ssh_host: localhost
        host: openshift.example.com
        roles:
            - msgserver
            - dbserver
            - nameserver
            - broker
            - node
    Districts:
      - gear_size: small
        node_hosts: openshift.example.com
        name: Default
    DNS:
        app_domain: app.example.net
        component_domain: example.com
        register_components: Y
        deploy_dns: Y
    Global:
        user_default_gear_sizes: small
        valid_gear_sizes: small
        broker_hostname:
        default_gear_size: small
Subscription:
    puppet_repo_rpm: http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
    jenkins_repo_base: http://pkg.jenkins-ci.org/redhat
    type: yum
    #os_optional_repo: http://download.fedoraproject.org/pub/epel/6/$basearch
    repos_base: https://mirror.openshift.com/pub/origin-server/release/4/rhel-6
Description: This is the configuration file for the OpenShift Installer.
Name: OpenShift Installer Configuration
Vendor: OpenShift Origin Community
Version: 0.0.1
Workflows:
    origin_deploy:
        dummy1: empty
        dummy2: empty
EOF
sh <(curl -s https://install.openshift.com/) -f ~/.openshift/oo-install-cfg.yml -w origin_deploy
echo '10.0.2.15 openshift.example.com' >> /etc/hosts
yum install -y shunit2
/vagrant/test/build_environment.sh
/vagrant/test/tests.sh
