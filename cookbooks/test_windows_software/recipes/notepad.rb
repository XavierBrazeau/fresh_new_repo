current_dir       = File.expand_path(File.dirname(__FILE__)) 

require 'json'
file = File.read("#{current_dir}/variables/variables.json")
data_hash = JSON.parse(file)

notepad_installer_path		= data_hash['file_paths']['notepad++']
notepad_url_path		= data_hash['remote_files']['notepad++']
code_string			= 'start-process -FilePath ' + notepad_installer_path + ' -ArgumentList "/S" -Verb runas -Wait'

remote_file notepad_installer_path do
  source notepad_url_path
  action :create
end

powershell_script 'Notepad++' do
  guard_interpreter :powershell_script
  code code_string
  not_if 'test-path -path "C:\Program Files\Notepad++"'
end

file notepad_installer_path do
  action :delete
end
