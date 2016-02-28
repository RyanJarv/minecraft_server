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

3. In this repos directory run `berks vendor`
4. To spin up the server run `chef-client -z provisioning/minecraft_server.rb`

