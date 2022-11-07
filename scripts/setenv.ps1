#Script to read in variables - cleartext! Will show in logs - do NOT use in prod.
$Env:TF_VAR_vsphere_user = Read-Host "Enter the vsphere user"
$Env:TF_VAR_vsphere_password = Read-Host "Enter the vsphere password"
$Env:PKR_VAR_username = Read-Host "Enter the username for the VM"
$Env:PKR_VAR_password = Read-Host "Enter the password for the VM"