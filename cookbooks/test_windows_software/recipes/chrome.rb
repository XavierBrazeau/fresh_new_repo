current_dir       = File.expand_path(File.dirname(__FILE__)) 

require 'json'
file = File.read("#{current_dir}/variables/variables.json")
data_hash = JSON.parse(file)

chrome_installer_path	= data_hash['file_paths']['chrome'].to_s
chrome_url_path		= data_hash['remote_files']['chrome'].to_s
code_string		= 'start-process -FilePath ' + chrome_installer_path

remote_file chrome_installer_path do
  source chrome_url_path
  action :create
end

#'http://dl.google.com/chrome/install/375.126/chrome_installer.exe'

powershell_script 'Chrome' do
  guard_interpreter :powershell_script
  code code_string
  not_if 'test-path -path "C:\Program Files (x86)\Google\Chrome"'
end

windows_package chrome_installer_path do
  action :remove
end