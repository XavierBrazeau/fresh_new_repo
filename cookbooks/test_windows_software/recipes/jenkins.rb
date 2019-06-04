remote_file C:\\Users\\sldev\\Documents\\jenkins.war do
  source http://mirrors.jenkins.io/war-stable/latest/jenkins.war
  action :create
end

powershell_script 'Jenkins' do
  #guard_interpreter :powershell_script
  code 'java -jar jenkins.war -FilePath C:\\Users\\sldev\\Documents\\jenkins.war'
  #not_if 'test-path -path "C:\Program Files (x86)\Google\Chrome"'
end