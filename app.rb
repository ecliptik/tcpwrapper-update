require "sinatra"
require "erb"

#Disable exceptions
disable :show_exceptions

#Update hosts.allow file using erb template
def update_file(ip)
  #Template of hosts.allow
  template = File.read("hosts.allow.erb")
  renderer = ERB.new(template).result(binding)

  #Write out file and return success or error
  File.write('hosts.allow', renderer)

  return "Updated to #{ip}"
end

#Single route to call update_file method and print result
get "/update" do
  result = update_file request.ip
  "#{result}"
end
