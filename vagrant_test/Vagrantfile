N = 1

Vagrant.configure("2") do |config|

	config.vm.define "master" do |master|
		master.vm.box = "centos/7"
		master.vm.host_name = "master"
		master.vm.provider :virtualbox do |spec|
			spec.memory = 2048
			spec.cpus = 2

		master.vm.provision "shell", inline: <<-SHELL
#su
su
vagrant

#install docker
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
systemctl start docker && systemctl enable docker

#SELinux
sudo setenforce 0

#enable br_netfilter & setting iptables
modprobe br_netfilter
cat <<EOF > /etc/sysctl.d/k8s.conf
	net.bridge.bridge-nf.call-ip6tables = 1
	net.bridge.bridge-nf-call-iptables = 1
EOF

#set YUM repository
touch /etc/yum.repos.d/kubernetes.repo
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF

#install kubeadm, kubectl, kubelet
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable kubelet && systemctl start kubelet

SHELL

end #master vm provision
end #master vm define

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

end #worker vm provision
end #worker vm define
end	#worker each
end