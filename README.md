# minecraft_server

1. Install ChefDK
2. Set up shell environment (will have to close and reopen tab after this). See the ChefDK <a href=https://docs.chef.io/install_dk.html>documentation</a> for more info

```bash
echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile
```

2. Put AWS api key in ~/.aws/config. The format looks like this:


...```
...[default]
...aws_access_key_id = XXXXXXXXXXXXXXXX
...aws_secret_access_key = XXXXXXXXXXXXXXXXXXXXXXXx
...region = us-east-1
...```

3. Pull down minecraft cookbook from GitHub

..* `git submodule init`
..* `git submodule update`

5. Pull down additional cookbooks from the Chef supermarket

..* `berks vendor`

6. If you want to add your own ssh key and give your self admin access add your username and ssh public key to ./cookbooks/my_minecraft_server/default.rb like so:

```ruby
node.override['admin']['name'] = '<your user name>'
node.override['admin']['pub_key'] = '<your ssh public key>'
```

..* If you don't have a ssh key you can generate one with `ssh-keygen`. Your public key will be located at ~/.ssh/id_rsa.pub

7. Spin up the server with chef-client

..* `chef-client -z provisioning/minecraft_server.rb`

