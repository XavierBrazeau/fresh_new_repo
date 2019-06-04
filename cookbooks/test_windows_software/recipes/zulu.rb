current_dir       = File.expand_path(File.dirname(__FILE__)) 

require 'json'
file = File.read("#{current_dir}/variables/variables.json")
data_hash = JSON.parse(file)

zulu_installer_path 	= data_hash['file_paths']['zulu']
zulu_url_path		= data_hash['remote_files']['zulu']
code_string		= 'msiexec.exe /I ' + zulu_installer_path + ' /quiet'

remote_file zulu_installer_path do
  source zulu_url_path
  action :create
end

powershell_script 'zulu' do
  guard_interpreter :powershell_script
  code code_string
  not_if 'test-path -path "C:\Program Files\Zulu"'
end

file zulu_installer_path do
  action :delete
end

powershell_script 'setPath' do
  code '$Env:Path += "C:\Program Files\Zulu\zulu-8\bin"'
end

