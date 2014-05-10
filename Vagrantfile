Vagrant::Config.run do |config|

  class String
    def stripMargin
      self.split(/$/).map { |line| line.sub(/(\s*\|)/, '') }.map { |line| line.slice(1..line.length) }.join("\n")
    end
  end

  config.vm.box = "hashicorp/precise64"
  config.vm.forward_port 4000, 4000

  script = <<-SSH
  | #!/bin/bash -ex
  | sudo apt-get update \
  | && sudo apt-get -y install build-essential git ruby1.9.3 \
  | && sudo gem install github-pages --no-ri --no-rdoc
  SSH

  config.vm.provision :shell, :inline => script.stripMargin


  config.ssh.forward_agent = true
end
