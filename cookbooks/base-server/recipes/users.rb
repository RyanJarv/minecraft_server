usr_name = node['admin']['name']

package 'zsh'

group usr_name do
  gid 1001
end

user usr_name do
  action :create
  group usr_name
  uid 1001
  shell '/usr/bin/zsh'
  home "/home/#{usr_name}"
  manage_home true
end

%w(sudo admin).each do |grp|
  group grp do
    append true
    members usr_name
  end
end


directory "/home/#{usr_name}/.ssh" do
  mode '0700'
  owner usr_name
  group usr_name
end

file "/home/#{usr_name}/.ssh/authorized_keys" do
  content node['admin']['pub_key']
  mode '0600'
  owner usr_name
  group usr_name
end


package 'git' # Needed for oh-my-zsh install
execute 'oh-my-zsh install' do
  command %Q(HOME=/home/#{usr_name} sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)")
  user usr_name
  group usr_name
  ignore_failure true # Meh
  not_if File::exist? "~#{usr_name}/.oh-my-zsh"
end


file '/etc/sudoers.d/no_passwd' do
  content "%sudo   ALL=(ALL:ALL) NOPASSWD: ALL\n"
end
