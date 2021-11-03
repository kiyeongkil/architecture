N = 1

Vagrant.configure("2") do |config|

	config.vm.define "master" do |master|
		master.vm.box = "centos/7"
		master.vm.host_name = "master"
		master.vm.provider :virtualbox do |spec|
			spec.memory = 2048
			spec.cpus = 2

		master.vm.provision "shell", inline: <<-SHELL
			#install docker
			yum install -y yum-utils device-mapper-persistent-data lvm2
			yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
			yum install -y docker-ce
			systemctl start docker && systemctl enable docker

			#SELinux
			sudo setenforce 0
		SHELL

		end
	end

	(1..N).each do |i|
		config.vm.define "worker#{i}" do |worker|
			worker.vm.box = "centos/7"
			worker.vm.host_name = "worker#{i}"
			worker.vm.provider :virtualbox do |spec|
				spec.memory = 2048
				spec.cpus = 2
			
			worker.vm.provision "shell", inline: <<-SHELL
				#install docker
				yum install -y yum-utils device-mapper-persistent-data lvm2
				yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
				yum install -y docker-ce
				systemctl start docker && systemctl enable docker
			SHELL

			end
		end
	end
end