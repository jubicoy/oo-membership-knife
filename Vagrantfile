# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
    config.vm.box = "jubic/centos-6.6"
    config.vm.hostname = "openshift.example.com"
    config.vm.network "forwarded_port", guest: 443, host: 8080
    config.vm.provision "shell", path: "bootstrap.sh"
end
