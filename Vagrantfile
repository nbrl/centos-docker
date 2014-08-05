# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Only needed if you need to use an intermediary VM. Set the environemntal
ORCHESTRATION_HOME = ENV['ORCHESTRATION_HOME']

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
   config.vm.provider "docker" do |d|
       d.build_dir = '.'
       d.has_ssh = true 
       d.vagrant_vagrantfile = "#{ ORCHESTRATION_HOME }/developer_environment/DockerHostVagrantfile"
   end
end
