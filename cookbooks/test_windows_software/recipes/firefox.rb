current_dir       = File.expand_path(File.dirname(__FILE__)) 

require 'json'
file = File.read("#{current_dir}/variables/variables.json")
data_hash = JSON.parse(file)

firefox_installer_path 	= data_hash['file_paths']['firefox']
firefox_url_path	= data_hash['remote_files']['firefox']
code_string 		= 'start-process -FilePath ' + firefox_installer_path + ' -ArgumentList "/S" -Verb runas -Wait' 	

remote_file firefox_installer_path do
  source firefox_url_path
  action :create
end

powershell_script 'firefox' do
  guard_interpreter :powershell_script
  code code_string
  not_if 'test-path -path "C:\Program Files\Mozilla Firefox"'
end

file firefox_installer_path do
  action :delete
end

