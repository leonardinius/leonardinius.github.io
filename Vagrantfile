Vagrant.configure("2") do |config|
  class String
    def stripMargin
      self.split(/$/).map { |line| line.sub(/(\s*\|)/, '') }.map { |line| line.slice(1..line.length) }.join("\n")
    end
  end

  config.vm.box = "hashicorp/precise64"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.define "leonardinius.galeoconsulting.com", primary: true do |cfg|
    cfg.vm.hostname = "leonardinius.galeoconsulting.com"
    cfg.vm.network "private_network", ip: "192.168.58.5"
    cfg.ssh.forward_agent = true

    config.vm.synced_folder "secret",           "/secret"

    script = <<-SSH
    | #!/bin/bash -ex
    | sudo apt-get update
    | sudo apt-get -y install dos2unix tmux
    |
    | sudo apt-get -y install build-essential git ruby1.9.3
    | sudo gem install github-pages --no-ri --no-rdoc
    |
    | sudo apt-get -y install nodejs
    | sudo gem install jekyll-sitemap --no-ri --no-rdoc
    SSH

    cfg.vm.provision :shell, :inline => script.stripMargin
  end
end
