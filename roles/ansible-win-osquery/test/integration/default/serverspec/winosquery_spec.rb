## https://github.com/mizzy/serverspec/blob/master/WINDOWS_SUPPORT.md
## http://shawinnes.com/testing-windows-infrastructure-with-serverspec/
## http://kitchen.ci/blog/test-kitchen-windows-test-flight-with-vagrant
## TARGET_HOST=192.168.2.109 rake spec

require 'serverspec'
require 'winrm'

set :backend, :winrm
set :os, :family => 'windows'

user = 'vagrant'
pass = 'vagrant'
endpoint = "http://#{ENV['TARGET_HOST']}:5985/wsman"

winrm = ::WinRM::WinRMWebService.new(endpoint, :ssl, :user => user, :pass => pass, :basic_auth_only => true)
winrm.set_timeout 300 # 5 minutes max timeout for any operation
Specinfra.configuration.winrm = winrm

#describe file('c:/ProgramData/osquery') do
describe file('c:/Program Files/osquery') do
  it { should be_directory }
  it { should be_readable }
  it { should_not be_writable.by('Everyone') }
end

describe package('osquery') do
  it { should be_installed}
end

