#
# Cookbook:: lamp
# Recipe:: web
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
#
package 'httpd' do
	action :install
end

template node['lamp']['index_path'] do
	source 'index.erb'
	variables ({generated_from_template: 'templatePower!!!!'})
end

#file node['lamp']['index_path'] do
#	action :create
#	content "<h1>Hello, world!</h1>
#	<p>ip address: #{node['ipaddress']}</p>
#	<p>hostname: #{node['hostname']}</p>
#	<p>total memory: #{node['memory']['total']}</p>
#	<p>platform: #{node['platform']}</p>
#	"
#end

service 'httpd' do 
	action [:start, :enable]
end
