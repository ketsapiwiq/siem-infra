# Ansible (+Terraform) demo infra for Wazuh manager, Linux and Windows Wazuh agents and osquery

Vulnerability detection, OSquery, fully-fledged Wazuh ELK stack with Linux and Windows Wazuh + osquery enrollment via Ansible.

## Run
### With Terraform

**_Careful: no firewall has been setup, your Terraform servers are listening on a public IP by default with NO KIBANA or ELASTIC AUTHENTICATION_**

1. Set your `terraform.tfvars`
2. Install Terraform plugin for your cloud provider
3. `terraform apply`
4. Install Ansible Terraform dynamic inventory binary at [adammck/terraform-inventory](https://github.com/adammck/terraform-inventory)
5. Set some variable due to a plugin issue: `export TF_STATE=./;` (see https://github.com/adammck/terraform-inventory/issues/144)
5. Run: `TF_STATE=./ wazuh-tf-single-node.yml wazuh-manager.yml wazuh-agent.yml`

### With VirtualBox
1. Import the [Wazuh VM](https://documentation.wazuh.com/3.13/installation-guide/virtual-machine.html)
2. Adapt the `wazuh-local.ini` inventory according to your network settings and desires
3. Set some variables, e.g.: `export ANSIBLE_HOST_KEY_CHECKING=False;`
1. Run: `ansible-playbook wazuh-vm-single-node.yml wazuh-manager.yml -i wazuh-local.ini`

#### Enroll the Linux agent
1. `ansible-playbook wazuh-agent.yml -i wazuh-local.ini`

####  Enroll the Windows agent
1. Setup a WinRM-reachable Windows environment in the Ansible inventory `wazuh-local.ini`
1. Run: `ansible-playbook wazuh-agent-win.yml -i wazuh-local.ini -k`
(on MacOS Cataline, do `export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES` before, see Bugs below)


## TODO
### Known issues
* `Get-Service OssecSvc` on Windows hosts: service is stopped after the playbook played.
* Troubleshoot Windows osquery bugs
### Features
* Add Powershell command execution logging and alerting
* Setup X-pack auth config + HTTPS/TLS certs everywhere
* [Active response](https://documentation.wazuh.com/3.13/user-manual/capabilities/active-response/how-it-works.html#when-is-an-active-response-triggered)

## Possible evolutions
* integrate other tools/sysinternals into ansible playbooks: https://docs.microsoft.com/en-us/sysinternals/downloads/rootkit-revealer
  * with a script to suspend all processes and dump RAM and disk (sysinternals) as an action response
* VirusTotal API / [Malice](https://github.com/maliceio/malice) / Cuckoo integration
* Suricata integration
* Multi-cluster / load-balanced Ansible playbook
  * K8s/Helm ?

### Low priority
* WAF / CI/CD for application security?
* more robust osquery configuration for Linux? https://github.com/palantir/osquery-configuration


## Workarounds
On MacOS Catalina, trying to use Ansible with WinRM, if you get:
```
objc[11628]: +[NSNumber initialize] may have been in progress in another thread when fork() was called.
objc[11628]: +[NSNumber initialize] may have been in progress in another thread when fork() was called. We cannot safely call it or ignore it in the fork() child process. Crashing instead. Set a breakpoint on objc_initializeAfterForkError to debug.
ERROR! A worker was found in a dead state
```

You need to set some variable: `export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES`
See https://github.com/ansible/ansible/issues/32499



## External documentation
- https://documentation.wazuh.com/3.13/user-manual/capabilities/vulnerability-detection/index.html#vulnerability-detection
- https://documentation.wazuh.com/3.13/user-manual/capabilities/osquery.html
- https://documentation.wazuh.com/3.13/user-manual/capabilities/log-data-collection/how-to-collect-wlogs.html