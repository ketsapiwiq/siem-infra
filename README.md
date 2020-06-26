# Demo infra for Wazuh manager and (Linux) agent with Ansible and Terraform 

Vulnerability detection already activated. OSquery in progress.

## Run
1. Set your `terraform.tfvars`
4. Install Terraform plugin for your cloud provider
2. `terraform apply`
3. Install Ansible Terraform dynamic inventory binary at [github.com/adammck/terraform-inventory](https://github.com/adammck/terraform-inventory)
4. Run: `TF_STATE=./ ansible-playbook wazuh-both.yml`

## See also
https://documentation.wazuh.com/3.13/user-manual/capabilities/vulnerability-detection/index.html#vulnerability-detection
https://documentation.wazuh.com/3.13/user-manual/capabilities/osquery.html