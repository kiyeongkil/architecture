Vagrant.configure("2") do |config|

	config.vm.define "master" do |master|
		master.vm.box = "centos/7"
		master.vm.host_name = "master"
		master.vm.provider :virtualbox do |spec|
			spec.memory = 2048
			spec.cpus = 2
		master.vm.provision "shell", inline: "yum install -y yum-utils device-mapper-persistent-data lvm2"
		master.vm.provision "shell", inline: "yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo"
		master.vm.provision "shell", inline: "yum install -y docker-ce"
		master.vm.provision "shell", inline: "systemctl start docker && systemctl enable docker"
	end
end

	config.vm.define "node1" do |node1|
		node1.vm.box = "centos/7"
		node1.vm.host_name = "node1"
		node1.vm.provider :virtualbox do |spec|
			spec.memory = 2048
			spec.cpus = 2
		node1.vm.provision "shell", inline: "yum install -y yum-utils device-mapper-persistent-data lvm2"
                node1.vm.provision "shell", inline: "yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo"
                node1.vm.provision "shell", inline: "yum install -y docker-ce"
                node1.vm.provision "shell", inline: "systemctl start docker && systemctl enable docker"
	end
end
end

$script = <<SCRIPT
	echo "##### Install yum-utils, device-mapper-persistent-data, lvm2"
	yum install -y yum-utils device-mapper-persistent-data lvm2

	echo "##### Add repository docker"
	yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

	echo "##### Install docker-ce"
	yum install docker-ce

	echo "##### Start & Enable Docker"
	systemctl start docker && systemctl enable docker	

SCRIPT
