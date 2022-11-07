#Must run ./setenv.ps1 first!
ConvertTo-Json @{
  vsphere_user =  $Env:TF_VAR_vsphere_user;
  vsphere_password = $Env:TF_VAR_vsphere_password;
  username = $Env:PKR_VAR_username;
  password = $Env:PKR_VAR_password
}