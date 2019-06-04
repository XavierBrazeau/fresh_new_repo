current_dir       = File.expand_path(File.dirname(__FILE__)) 

remote_file "#{current_dir}/variables/firefox_version.json" do
  source 'https://product-details.mozilla.org/1.0/firefox_versions.json'
  action :create
end

require 'json'
version_file = File.read("#{current_dir}/variables/firefox_version.json")
version_hash = JSON.parse(version_file)

latest_version = version_hash["LATEST_FIREFOX_VERSION"]

variables_read = File.read("#{current_dir}/variables/variables.json")
variables_hash = JSON.parse(variables_read)

FIREFOX_LATEST_URL = "https://download-origin.cdn.mozilla.net/pub/firefox/releases/" + latest_version + "/win64-EME-free/en-US/Firefox Setup " + latest_version + ".exe"

variables_hash["remote_files"]["firefox"] = FIREFOX_LATEST_URL

variables_write = File.open("#{current_dir}/variables/variables.json", "w")

puts JSON.pretty_generate(variables_hash)

variables_write.write(JSON.pretty_generate(variables_hash))

variables_write.close


file '#{current_dir}/variables/firefox_version.json' do
  action :delete
end



