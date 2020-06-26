# Ansible (+Terraform) demo infra for Wazuh manager, Linux and Windows Wazuh agents and osquery

Vulnerability detection, OSquery, fully-fledged Wazuh ELK stack with Linux and Windows Wazuh + osquery enrollment via Ansible.

## Run
### With Terraform
1. Set your `terraform.tfvars`
2. Install Terraform plugin for your cloud provider
3. `terraform apply`
4. Install Ansible Terraform dynamic inventory binary at [github.com/adammck/terraform-inventory](https://github.com/adammck/terraform-inventory)
5. Set some variables: `export TF_STATE=./;` (see https://github.com/adammck/terraform-inventory/issues/144)

### With VirtualBox
1. Import the [Wazuh VM](https://documentation.wazuh.com/3.13/installation-guide/virtual-machine.html)
2. Adapt inventory according to your network settings
3. ??? (playbooks not tested on CentOS)

### Run

1. Set some variables, e.g.: `export ANSIBLE_HOST_KEY_CHECKING=False; export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES` _(on MacOS, see https://github.com/ansible/ansible/issues/32499)
5. Run: `ansible-playbook wazuh-both.yml`

## TODO
* [Active response](https://documentation.wazuh.com/3.13/user-manual/capabilities/active-response/how-it-works.html#when-is-an-active-response-triggered)
* Multi-cluster / load-balanced Ansible playbook
  * K8s/Helm ?
* Suricata integration
* VirusTotal / [Malice](https://github.com/maliceio/malice) / Cuckoo integration

## See also
https://documentation.wazuh.com/3.13/user-manual/capabilities/vulnerability-detection/index.html#vulnerability-detection
https://documentation.wazuh.com/3.13/user-manual/capabilities/osquery.html
