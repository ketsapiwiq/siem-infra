# Ansible (+Terraform) demo infra for Wazuh manager, Linux and Windows Wazuh agents and osquery

Vulnerability detection, OSquery, fully-fledged Wazuh ELK stack with Linux and Windows Wazuh + osquery enrollment via Ansible.

## Run
1. Set your `terraform.tfvars`
4. Install Terraform plugin for your cloud provider
2. `terraform apply`
3. Install Ansible Terraform dynamic inventory binary at [github.com/adammck/terraform-inventory](https://github.com/adammck/terraform-inventory)
4. Run: `TF_STATE=./ ansible-playbook wazuh-both.yml`

## TODO
* Active response
* Multi-cluster / load-balanced Ansible playbook
  * K8s/Helm ?
* Suricata integration
* VirusTotal / [Malice](https://github.com/maliceio/malice) / Cuckoo integration


## See also
https://documentation.wazuh.com/3.13/user-manual/capabilities/vulnerability-detection/index.html#vulnerability-detection
https://documentation.wazuh.com/3.13/user-manual/capabilities/osquery.html
