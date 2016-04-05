# -*- mode: ruby -*-
# vi: set ft=ruby :


$script = <<SCRIPT
sudo apt-get update
sudo apt-get install linux-headers-$(uname -r)

if ! docker_loc="$(type -p "docker")" || [ -z "$docker_loc" ]; then
    wget -qO- https://get.docker.com/ | sh
    sudo usermod -aG docker vagrant
    sudo mkdir -p /data
fi

if ! docker_compose_loc="$(type -p "docker-compose")" || [ -z "$docker_compose_loc" ]; then
    sudo curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

SCRIPT

Vagrant.require_version ">= 1.6.0"

Vagrant.configure("2") do |config|

    config.vm.hostname = "windows-host"

    config.vm.box_check_update = false

    config.vm.box = "ubuntu/trusty64"

    config.vm.network "private_network", ip: "{{ dev_ip_address }}"

    config.vm.network "forwarded_port", guest: 80, host: 8080

    config.vm.synced_folder '{{ path.working }}' , "/vagrant", owner: "vagrant", group: "vagrant"

    config.vm.provider "virtualbox" do |vb|
        vb.name = "{{ name }}"
        vb.gui = false
        vb.memory = "2048"
        vb.cpus = 2
    end

    config.vm.provision "shell", inline: $script, privileged: true

    if Vagrant.has_plugin?("vagrant-cachier")
      config.cache.scope = :box
    end
end
