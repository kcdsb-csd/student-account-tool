import-module ActiveDirectory
write-host ("loaded module. looking for user = " + $PoSHUserName)
# validate user
try {
  $username = $PoSHUsername.split('\\')[1]
  if (((Get-ADGroupMember "All Permanent Staff" -Recursive).name -contains $(get-aduser $username).Name) -eq $false) {
    write-host ("invalid group: user = " + $PoSHUserName)
    @{"poshusername" = ""} | ConvertTo-Json
    return
  }
} catch {
  write-host ($_.Exception.Message);
  @{"poshusername" = ""} | ConvertTo-Json
  return
}

write-host ("valid group: user = " + $PoSHUserName)
Write-EventLog -LogName Application -Source StudentServices -EventId 5555 -Message $("User $cred_username : logged in.")
@{ "poshusername" = $PoSHUserName} | ConvertTo-Json
