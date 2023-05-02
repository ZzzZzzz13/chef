package 'httpd' do
    action :install
end
package 'php' do
    action :install
end
package 'php-mysqlnd' do
    action :install
end
service 'httpd' do
    action [ :enable, :start ]
end
execute 'httpd_firewall' do
    command 'sudo firewall-cmd --add-service=http'
    ignore_failure true
end
  
execute 'reload_firewall' do
    command 'sudo firewall-cmd --reload'
    ignore_failure true
end

execute 'conf_selinux' do
    command 'sudo setsebool -P httpd_can_network_connect=1'
    ignore_failure true
end
cookbook_file '/var/www/html/bulgaria-map.png' do
    source 'files/bulgaria-map.png'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end
cookbook_file '/var/www/html/index.php' do
    source 'files/index.php'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end