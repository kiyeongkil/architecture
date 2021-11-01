Vagrant.configure("2") do |config|

	config.vm.define "master" do |master|
		master.vm.box = "centos/7"
		master.vm.host_name = "master"
		master.vm.provider :virtualbox do |spec|
			spec.memory = 2048
			spec.cpus = 2
	end
end

	config.vm.define "node1" do |node1|
		node1.vm.box = "centos/7"
		node1.vm.host_name = "node1"
		node1.vm.provider :virtualbox do |spec|
			spec.memory = 2048
			spec.cpus = 2
	end
end
end
