# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

    config.vm.define :manager do |manager|

        # Every Vagrant development environment requires a box. You can search for
        # boxes at https://vagrantcloud.com/search.
        manager.vm.box = "ubuntu/focal64"
        manager.vm.hostname = "manager"
        
        # Disable automatic box update checking. If you disable this, then
        # boxes will only be checked for updates when the user runs
        # `vagrant box outdated`. This is not recommended.
        # config.vm.box_check_update = false

        # Create a forwarded port mapping which allows access to a specific port
        # within the machine from a port on the host machine. In the example below,
        # accessing "localhost:8080" will access port 80 on the guest machine.
        # NOTE: This will enable public access to the opened port
        # config.vm.network "forwarded_port", guest: 80, host: 8080

        # Create a forwarded port mapping which allows access to a specific port
        # within the machine from a port on the host machine and only allow access
        # via 127.0.0.1 to disable public access
        manager.vm.network "forwarded_port", guest: 5601, host: 5601, host_ip: "127.0.0.1"

        # Create a private network, which allows host-only access to the machine
        # using a specific IP.
        manager.vm.network :private_network, ip: "192.168.33.10"

        # manager.vm.disk :disk, size: "20GB"
        manager.vm.disk :disk, size: "20GB", primary: true

        
        # Create a public network, which generally matched to bridged network.
        # Bridged networks make the machine appear as another physical device on
        # your network.
        # config.vm.network "public_network"

        # Share an additional folder to the guest VM. The first argument is
        # the path on the host to the actual folder. The second argument is
        # the path on the guest to mount the folder. And the optional third
        # argument is a set of non-required options.
        # config.vm.synced_folder "../data", "/vagrant_data"

        # Provider-specific configuration so you can fine-tune various
        # backing providers for Vagrant. These expose provider-specific options.
        # Example for VirtualBox:
        #
        manager.vm.provider "virtualbox" do |vb|
          # Display the VirtualBox GUI when booting the machine
        #   vb.gui = true
        
          # Customize the amount of memory on the VM:
          vb.memory = "8192"
        end
        #
        # View the documentation for the provider you are using for more
        # information on available options.

        # Enable provisioning with a shell script. Additional provisioners such as
        # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
        # documentation for more information about their specific syntax and use.
        # config.vm.provision "shell", inline: <<-SHELL
        #   apt-get update
        #   apt-get install -y apache2
        # SHELL

        manager.vm.provision "ansible" do |ansible|
            ansible.playbook = "wazuh-vm-single-node.yml"
        end
    end


    config.vm.define :linux_agent do |linux_agent|
        linux_agent.vm.box = "ubuntu/focal64"
        linux_agent.vm.hostname = "linux-agent-1"
        # linux_agent.vm.network "forwarded_port", guest: 5601, host: 5601, host_ip: "127.0.0.1"

        linux_agent.vm.network :private_network, ip: "192.168.33.30"

        # config.vm.network "public_network"

        # config.vm.synced_folder "../data", "/vagrant_data"

        linux_agent.vm.provider "virtualbox" do |vb|
          # Customize the amount of memory on the VM:
        #   vb.memory = "8192"
        end

        # $script = <<-'SCRIPT'
        # curl -so wazuh-agent-4.2.4.deb https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.2.4-1_amd64.deb && sudo WAZUH_MANAGER='192.168.33.10' WAZUH_AGENT_GROUP='default' dpkg -i ./wazuh-agent-4.2.4.deb
        # sudo systemctl daemon-reload
        # sudo systemctl enable wazuh-agent
        # sudo systemctl restart wazuh-agent
        # SCRIPT

        # linux_agent.vm.provision "shell", inline: $script
        
        linux_agent.vm.provision "ansible" do |ansible|
            ansible.playbook = "wazuh-agent.yml"
        end
    end


    config.vm.define :win_agent do |win_agent|
        win_agent.vm.box = "gusztavvargadr/windows-10"
        # win_agent.vm.box = "Microsoft/EdgeOnWindows10"
        win_agent.vm.guest = :windows
        win_agent.vm.hostname = "win-agent"
        win_agent.vm.network "private_network", ip: "192.168.33.20"

        # win_agent.vm.communicator = "winrm"
        # win_agent.vm.communicator = "ssh"
        win_agent.vm.communicator = "winssh"

        # $script = <<-'SCRIPT'
        # [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        # $url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
        # $file = "$env:temp\ConfigureRemotingForAnsible.ps1"

        # (New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

        # powershell.exe -ExecutionPolicy ByPass -File $file -Verbose
        # SCRIPT

        # win_agent.vm.provision "shell",
        # inline: $script

        # win_agent.vm.provision "shell",
        # # inline: "Invoke-WebRequest -Uri https://packages.wazuh.com/4.x/windows/wazuh-agent-4.2.4-1.msi -OutFile wazuh-agent-4.2.4.msi; ./wazuh-agent-4.2.4.msi /q WAZUH_MANAGER='192.168.33.10' WAZUH_AGENT_NAME='win-agent' WAZUH_REGISTRATION_SERVER='192.168.33.10' WAZUH_AGENT_GROUP='default'"

        win_agent.vm.provision "ansible" do |ansible|
            # https://github.com/hashicorp/vagrant/issues/10765#issuecomment-503806606
            ansible.extra_vars = {
                    # "ansible_user": "vagrant",
                    # "ansible_connection": "ssh",
                    #  ansible_host_key_checking=False
                    "ansible_shell_type": "cmd"
                    # "ansible_private_key_file" => "~/.vagrant.d/insecure_private_key",
        
                    #  "ansible_winrm_scheme" => "http",
                    #  "ansible_winrm_transport" => "basic",
                    #  "ansible_winrm_server_cert_validation" => "ignore",
                    #  "ansible_connection" => "psrp",
                    #  "ansible_psrp_transport" => "basic",
                    #  "ansible_psrp_cert_validation" => "ignore"    
                }
            ansible.raw_arguments = ['--diff', '-vv']
            
            ansible.playbook = "wazuh-agent-win.yml"
                    
        end
        
        # default ansible_connection=winrm ansible_host=127.0.0.1 ansible_port=55985 ansible_user='vagrant' ansible_password='vagrant'


    end
end
  
  