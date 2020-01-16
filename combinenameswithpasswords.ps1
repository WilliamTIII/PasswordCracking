$hashes=get-content d:\output\ntlm-hashes.ntds
$pass=get-content d:\output\cracked.out

$out=@()
foreach($password in $pass){
    $user = (get-aduser (($hashes | select-string -pattern ($password.split(":")[0])).tostring().split(":")[0]).split("\")[1]).userprincipalname
    $passwd=$password.split(":")[1]
    $out+=New-Object psObject -Property @{'User'=$user;'Password'= $passwd}
}

$out