include_recipe 'apt'


node.override['apt']['unattended_upgrades']['mail'] = 'ryan_gerstenkorn@fastmail.fm'
node.override['apt']['unattended_upgrades']['remove_unused_dependencies'] = true
node.override['apt']['unattended_upgrades']['automatic_reboot'] = true
node.override['apt']['unattended_upgrades']['allowed_origins']

include_recipe 'apt::unattended-upgrades'

# Run updates on first boot, reboot after first chef run
execute 'apt-get security updates' do
  command '/usr/bin/unattended-upgrade'

  notifies :create, 'file[apt-upgrade-lock]'
  notifies :request_reboot, 'reboot[apply configuration]'

  not_if { ::File.exists?('/etc/apt/.first_run_upgrade') }
end

file 'apt-upgrade-lock' do
  path '/etc/apt/.first_run_upgrade'
  action :nothing
end

reboot 'apply configuration' do
  action :nothing
  reason 'Rebooting to apply configuration changes'
end
