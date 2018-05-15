# # encoding: utf-8
control 'zabbix-agent' do
  impact 1.0
  title 'Configure zabbix-agent'

  if os.suse?
    zabbix_service = 'zabbix-agentd'
    zabbix_commands = %w(zabbix-agent zabbix-sender)
    zabbix_packages = %w(zabbix-agent)
    zabbix_processes = 'zabbix-agentd'
  else
    zabbix_service = 'zabbix-agent'
    zabbix_commands = %w(zabbix_agentd zabbix_sender)
    zabbix_packages = %w(zabbix-release zabbix-agent zabbix-sender)
    zabbix_processes = 'zabbix_agentd'
  end

  zabbix_packages.each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end

  zabbix_commands.each do |c|
    describe command(c) do
      it { should exist }
    end
  end

  describe service(zabbix_service) do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  describe port(10050) do
    its('processes') { should include zabbix_processes }
    its('protocols') { should include 'tcp' }
    its('addresses') { should include '0.0.0.0' }
  end
end
