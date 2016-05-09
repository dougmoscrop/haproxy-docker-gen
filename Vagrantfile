unless Vagrant.has_plugin?("vagrant-vbguest")
	STDERR.puts "Please install the vagrant-vbguest plugin with the following command:"
	STDERR.puts ">> vagrant plugin install vagrant-vbguest"

	abort
end

Vagrant.require_version ">= 1.7.0"
Vagrant::configure("2") do |config|

	config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
	config.vm.box = "phusion/ubuntu-14.04-amd64"

	config.vm.provider :virtualbox do |v, o|
		o.vm.network "private_network", ip: "169.0.13.37"
	end

  config.vm.provision :docker
	config.vm.provision :shell, path: "docker-compose.sh"
	config.vm.provision :shell,
		inline: "docker-compose -f /vagrant/docker-compose.yml pull"

	config.vm.provision :shell, run: :always,
		inline: "dev_ip=$(netstat -rn | grep '^0.0.0.0' | cut -d ' ' -f10) docker-compose -f /vagrant/docker-compose.yml up -d --build --remove-orphans"

end
