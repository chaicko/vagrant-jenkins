# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.require_version ">=1.8.0"

Vagrant.configure("2") do |config|
  config.vm.define "devopsbox" do |devopsbox|
      # A vagrant Box with almost all we need
      devopsbox.vm.box = "darkwizard242/devopsubuntu1804"
      devopsbox.vm.hostname = "devops"
      devopsbox.vm.network "forwarded_port", guest: 80, host: 8080
      devopsbox.vm.synced_folder ".", "/mnt/host_machine"
      devopsbox.vm.provider :virtualbox do |vb|
          vb.name = "devops"
          vb.memory = "2048"
      end
      devopsbox.vm.provision "shell" do |s|
        s.path = "provision.sh"
      end
      #devopsbox.vm.provision "ansible_local" do |ansible|
      #  ansible.verbose = "v"
      #  ansible.become = true
      #  ansible.playbook = "playbook.yml"
      #  ansible.galaxy_role_file = "requirements.yml"
      #  ansible.galaxy_roles_path = "/etc/ansible/roles"
      #  ansible.galaxy_command = "sudo ansible-galaxy install --role-file=%{role_file} --roles-path=%{roles_path} --force"
      #  ansible.playbook = "playbook.yml"
      #end
  end
end
