<#
Version: 1.0
Author: Andrei Pintica
Creation Date: 05.07.2017 
Purpose: change domain user passwrod to the curent one
Premises: curent domain password policy: history = 24 / password length = 8 / 

VERSION HISTORY
1.0 - it works.
#>

#Requires -Version 3.0
#Requires -Module ActiveDirectory


$CurrentCredential = Get-Credential -Message 'Enter current domain credentials:'


$Intermediate = (
    'w%fAP7d@}m.^&V:g',
    'Mj?Tp=h_RH8ZjV&/',
    '6`{a?3L9j>mQNBu&',
    'xF$N5c\fHFf:>.7B',
    ')fv^b'w'3Ny[L2[N',
    'GRfs4%yr*#c`"$rt',
    '6uqb%JQH9:9f7j<V',
    'J%s%6H9&w.~LW~y{',
    'L]*nYy_c~?z9_ECz',
    '\hc-7v)Z\{sDFm.7',
    'KSa&3GKd$/Sw&x5C',
    'M+z35Qw5y/;(Zttd',
    '$~CZV.pdN^2S^WbA',
    'V8m*L5}H@ek-szUf',
    ']R6sJC3Bw4\J=-7n',
    'b/rTV9S*qwJ$75.7',
    'Ypz[#5)VJcm@A-]~',
    '38_9/TV/+sD&raZa',
    'r}'bU=)Ar?vp@[5,',
    '~)HrLVb;U7:Wdv%.',
    '._vkg\52+BR9bnRC',
    '%'@Xqj82JvE2$R_Q',
    'M,:G_Z\4$gfdQvV;',
    'zC['Qen:*$t>WQ6&',
    '_^L?r$>5rtqxNf!j'
)


$PlainPwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($CurrentCredential.Password))

if($CurrentCredential.UserName.ToLower().StartsWith('office\')){ 
    $Username = $CurrentCredential.UserName.Replace('office\','')
}
else{
    $Username = $CurrentCredential.UserName
}

$OldPass = $CurrentCredential.Password

foreach($IntPass in $Intermediate){
    $IntSecPass =  ConvertTo-SecureString -AsPlainText $IntPass -Force
    Set-ADAccountPassword -Identity $Username -OldPassword $OldPass -NewPassword $IntSecPass

    $OldPass = $IntSecPass
}

Set-ADAccountPassword -Identity $Username -OldPassword $OldPass -NewPassword $CurrentCredential.Password 
