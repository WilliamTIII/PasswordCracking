#python -m SimpleHTTPServer
#copy the files into one dir, then run this. connect to kali IP:8000

$hashes=get-content C:\steve\ntds\ntlm-extract.ntds
$pass=get-content C:\steve\ntds\cracked.out

Add-Type -AssemblyName System.DirectoryServices.AccountManagement
$DS = New-Object System.DirectoryServices.AccountManagement.PrincipalContext('domain')


$out=@()


foreach($password in $pass){
    $passwordlocation=($hashes | select-string -pattern ($password.split(":")[0]))
    if($passwordlocation.count -gt 1){
        foreach($individual in $passwordlocation){
            $user = (get-aduser ($individual.tostring().split(":")[0]).split("\")[1]).userprincipalname
            $passwd=$password.split(":")[1]
            $passresult=($DS.ValidateCredentials($user, $passwd))
            $out+=New-Object psObject -Property @{'User'=$user;'Password'= $passwd;'CurrentPasswd'=$passresult}
        }
        continue
    }
    else{
        $user = (get-aduser ($passwordlocation.tostring().split(":")[0]).split("\")[1]).userprincipalname
        $passwd=$password.split(":")[1]
        $passresult=($DS.ValidateCredentials($user, $passwd))
        $out+=New-Object psObject -Property @{'User'=$user;'Password'= $passwd;'CurrentPasswd'=$passresult}
        continue
    }
    
}



$out

