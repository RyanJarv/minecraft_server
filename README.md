# AWS Minecraft Server

Some of the commands in this readme assume your current working directory is wherever you cloned this repo, you will want to cd to that
      directory when following this guide. So if you ran `git clone https://github.com/RyanJarv/minecraft_server.git` while you where in your
      ~/Documents folder then you would want to cd this repo with `cd ~/Documents/minecraft_server`.
      
I'm also assumming you are running on OSX or Linux. I haven't tested it but it should work on Windows as well, you however may have to do some reading to find the equivelent commands on windows. Mainly the ChefDK and AWS setup steps will be different.

By default this creates a FTB server which requires the FTB <a href=http://www.feed-the-beast.com/>client</a>, if you want a unmodded minecraft server reade the optional steps below.

1. Install the ChefDK, located <a href=https://downloads.chef.io/chef-dk/>here</a>.
2. Set up chef shell environment. See the ChefDK <a href=https://docs.chef.io/install_dk.html>documentation</a>
   for more info.

  * This command will set up the chef environment for future bash sessions. You will need to close and reopen your
    terminal after running this.

    ```bash
    echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile
    ```

2. Put AWS api key in ~/.aws/credentials and create an empty ~/.aws/config

  * Create the ~/.aws folder with `mkdir ~/.aws`

  * The format of ~/.aws/credentials will look like this, replace the X's with your api info.

      ````
      [default]
      aws_access_key_id = XXXXXXXXXXXXXXXX
      aws_secret_access_key = XXXXXXXXXXXXXXXXXXXXXXXx
      region = us-east-1
      ````
  * Since your api key should be kept secure you can limit access to it by running `chmod o-rwx ~/.aws/credentials`

3. Pull down minecraft cookbook from GitHub.

  ```
  git submodule init
  git submodule update
  ```

4. Pull down additional cookbooks from the Chef supermarket.

  ```
  berks vendor
  ```

5. Spin up the server with chef-client.

  ```chef-client -z provisioning/minecraft_server.rb```
  
6. You should now beable to connect to the server in Minecraft with the public server IP, you can find this in the AWS
   control panel. If you didn't change the install_type setting below in the optional steps then you will need to use the modified FTB launcher to connect to your server which you can get <a href=http://www.feed-the-beast.com/>here</a>.


###Optional Steps


* Create your own admin account by adding a username and your ssh public key to ./cookbooks/my_minecraft_server/default.rb

  ```ruby
  node.override['admin']['name'] = '<your user name>'
  node.override['admin']['pub_key'] = '<your ssh public key>'
  ```

  * If you don't have a ssh key you can generate one with `ssh-keygen`. Your public key will be located at ~/.ssh/id_rsa.pub
  * If you don't create an account usuing these attributes you can still access the server using the default key at     .chef/keys/chef_default with the ubuntu account

  ```ssh -i .chef/keys/chef_default -l ubuntu <ip_address>```

* Change the AWS node size in ./provisioning/minecraft_server.rb

  ```instance_type: 't2.medium'```

  * The t2.micro is free for a period of time on new AWS accounts.
  * A full list of available instance types can be found <a href=https://aws.amazon.com/ec2/instance-types/>here</a>.
  * If you are creating a FTB server you will need at the very least a t2.small, vanilla will run on a t2.tiny

* Change the type of minecraft server in ./cookbooks/my_minecraft_server/default.rb

  ```ruby
  # node.override['minecraft']['install_type'] = 'vanilla'
  # node.override['minecraft']['install_type'] = 'bukkit'
  # node.override['minecraft']['install_type'] = 'spigot'
  node.override['minecraft']['install_type'] = 'ftb'
  ```

  * Only one type can be selected

