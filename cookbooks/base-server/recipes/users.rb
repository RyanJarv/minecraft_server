package 'zsh'

group 'ryan' do
  gid 1001
end

user 'ryan' do
  action :create
  group 'ryan'
  uid 1001
  shell '/usr/bin/zsh'
  home '/home/ryan'
  manage_home true
end

directory '/home/ryan/.ssh' do
  mode '0700'
  owner 'ryan'
  group 'ryan'
end

cookbook_file '/home/ryan/.ssh/authorized_keys' do
  source 'authorized_keys'
  mode '0600'
  owner 'ryan'
  group 'ryan'
end

# Needed for oh-my-zsh install
package 'git'

execute 'oh-my-zsh install' do
  command 'HOME=/home/ryan sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
  user 'ryan'
  group 'ryan'
  ignore_failure true # Meh
  not_if File::exist? '~ryan/.oh-my-zsh'
end

