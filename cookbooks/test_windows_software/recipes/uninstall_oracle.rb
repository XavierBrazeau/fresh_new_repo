powershell_script 'uninstall_oracle' do
  code 'gwmi Win32_Product -filter "name like \'Java%\' AND (vendor like \'Oracle%\' OR vendor like \'Sun%\')" | % { if (Get-Member -In $_ -Name "Uninstall" -Mem Method) { Write-Host "Uninstalling $($_.Name)"; $_.Uninstall().ReturnValue; } }'
end