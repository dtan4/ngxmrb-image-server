if server_name == "NGINX"
  Server = Nginx
elsif server_name == "Apache"
  Server = Apache
end

Server::rputs "Welcome to ngx_mruby world!"
