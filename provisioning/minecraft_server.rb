require 'chef/provisioning/aws_driver'

with_driver 'aws::us-east-1'

repo_root = File.expand_path File.join(File.dirname(__FILE__), '..')

with_chef_local_server :chef_repo_path => repo_root,
                       :cookbook_path => %W(
                           #{repo_root}/cookbooks
                           #{repo_root}/berks-cookbooks
                       )

my_sg = aws_security_group 'minecraft_server' do
  inbound_rules '0.0.0.0/0' => [ 22, 25565 ]
end

machine 'minecraft_server' do
  recipe 'my_minecraft_server'
  machine_options(
                    lazy do
                      {
                          bootstrap_options: {
                               image_id: 'ami-fce3c696',
                               instance_type: 't2.micro',
                               key_name: 'minecraft_server',
                               security_group_ids: [my_sg.aws_object.id]
                           }
                       }
                    end
  )
end

