# AWS Minecraft Server

1. Install ChefDK.
2. Set up shell environment (will have to close and reopen tab after this). See the ChefDK <a href=https://docs.chef.io/install_dk.html>documentation</a> for more info.

  ```bash
  echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile
  ```

2. Put AWS api key in ~/.aws/config

  ````
  [default]
  aws_access_key_id = XXXXXXXXXXXXXXXX
  aws_secret_access_key = XXXXXXXXXXXXXXXXXXXXXXXx
  region = us-east-1
  ````

3. Pull down minecraft cookbook from GitHub.

  ```
  git submodule init
  git submodule update
  ```

5. Pull down additional cookbooks from the Chef supermarket.

  ```
  berks vendor
  ```

6. OPTIONAL: Create your own admin account by adding a username and your ssh public key to ./cookbooks/my_minecraft_server/default.rb

  ```ruby
  node.override['admin']['name'] = '<your user name>'
  node.override['admin']['pub_key'] = '<your ssh public key>'
  ```

* If you don't have a ssh key you can generate one with `ssh-keygen`. Your public key will be located at ~/.ssh/id_rsa.pub
* If you don't create an account usuing these attributes you can still access the server using the default key at .chef/keys/chef_default with the ubuntu account

```ssh -i .chef/keys/chef_default -l ubuntu <ip_address>```

7. OPTIONAL: Change the AWS node size in ./provisioning/minecraft_server.rb

  ```instance_type: 't2.micro'```

  * The t2.micro is free for a period of time on new AWS accounts.
  * A full list of available instance types can be found <a href=https://aws.amazon.com/ec2/instance-types/>here</a>.

8. Spin up the server with chef-client.

  ```chef-client -z provisioning/minecraft_server.rb```

