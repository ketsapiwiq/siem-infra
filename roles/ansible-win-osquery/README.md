[![Build Status - Master](https://travis-ci.org/juju4/ansible-win-osquery.svg?branch=master)](https://travis-ci.org/juju4/ansible-win-osquery)
[![Build Status - Devel](https://travis-ci.org/juju4/ansible-win-osquery.svg?branch=devel)](https://travis-ci.org/juju4/ansible-win-osquery/branches)(Syntax Only)

[![Appveyor - Master](https://ci.appveyor.com/api/projects/status/j4e34u1swf3keo6y?svg=true)](https://ci.appveyor.com/project/juju4/ansible-win-osquery)
![Appveyor - Devel](https://ci.appveyor.com/api/projects/status/j4e34u1swf3keo6y/branch/devel?svg=true)

# Windows osquery ansible role

Ansible role to setup osquery on windows system.

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.4 (required since s/include:/include_tasks:/)

### Operating systems

Tested against Win10 and Ws2016 Evaluation.
Follow http://kitchen.ci/blog/test-kitchen-windows-test-flight-with-vagrant/

## Example Playbook

Just include this role in your list.
For example

```
- host: all
  roles:
    - juju4.win-osquery
```

Run
```
$ ansible -i inventory -m win_ping win --ask-pass
$ ansible-playbook -i inventory --limit win site.yml
```

## Variables

See defaults/main.yml for full scope

## Continuous integration

This role has a travis basic test (for github, syntax check only) and a Vagrantfile (test/vagrant).

```
$ cd /path/to/roles/juju4.win-osquery/test/vagrant
$ vagrant up
$ vagrant provision
$ vagrant destroy
$ ansible -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory -m win_ping -e ansible_winrm_server_cert_validation=ignore -e ansible_ssh_port=55986 all
```

## Troubleshooting & Known issues

## FAQ

## License

BSD 2-clause

