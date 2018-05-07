# # encoding: utf-8
describe package('zabbix-release') do
  it { should be_installed }
end

describe package('zabbix-sender') do
  it { should be_installed }
end

describe package('zabbix-agent') do
  it { should be_installed }
end

describe service('zabbix-agent') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(10050) do
  its('processes') { should include 'zabbix_agentd' }
  its('protocols') { should include 'tcp' }
  its('addresses') { should include '0.0.0.0' }
end
