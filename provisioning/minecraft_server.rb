require 'chef/provisioning/aws_driver'

with_driver 'aws::us-east-1'

repo_root = File.expand_path File.join(File.dirname(__FILE__), '..')

with_chef_local_server :chef_repo_path => '/Users/ryangerstenkorn/Code/minecraft_server',
                       :cookbook_path => %W(
                           #{repo_root}/cookbooks
                           #{repo_root}/berks-cookbooks
                       )

machine 'minecraft_server' do
  recipe 'my_minecraft_server'
  machine_options({
                           bootstrap_options: {
                               image_id: 'ami-fce3c696',
                               instance_type: 't2.micro',
                               key_name: 'minecraft_server',
                           }
                       })
end

