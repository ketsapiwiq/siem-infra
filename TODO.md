

## TODO
### Known issues
* `Get-Service OssecSvc` on Windows hosts: service is stopped after the playbook played.
* Troubleshoot Windows osquery bugs
### Features
* Add Powershell command execution logging and alerting
* Setup X-pack auth config + HTTPS/TLS certs everywhere
* [Active response](https://documentation.wazuh.com/3.13/user-manual/capabilities/active-response/how-it-works.html#when-is-an-active-response-triggered)

## Possible evolutions
* add minotring of node modules security output recurring task (npm audit)
* integrate other tools/sysinternals into ansible playbooks: https://docs.microsoft.com/en-us/sysinternals/downloads/rootkit-revealer
  * with a script to suspend all processes and dump RAM and disk (sysinternals) as an action response
* VirusTotal API / [Malice](https://github.com/maliceio/malice) / Cuckoo integration
* Suricata integration
* Multi-cluster / load-balanced Ansible playbook
  * K8s/Helm ?

### Low priority
* WAF / CI/CD for application security?
* more robust osquery configuration for Linux? https://github.com/palantir/osquery-configuration
