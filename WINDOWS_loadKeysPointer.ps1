$pendriveName = "K-MSM-00";

$service1 = ":/.ssh/github";  
$service2 = ":/.ssh/gitlab";
$userService1 = "Matoruzito";
$userService2 = "Matoruzito";

$destinationInHome = "~/.ssh/config";



Get-WmiObject -Class Win32_logicaldisk  | Where-Object VolumeName -EQ $pendriveName  | Select-Object  "DeviceId" > infoExtraible.txt;

$i = 0
$contentByLines = ""
foreach($line in Get-Content .\infoExtraible.txt) {
       
       $contentByLines += $line;
       
       $i++;
}

$letterOfExtraible = $contentByLines[16]; #Identifier of Pendrive or extraible flash unit

#EDIT THIS TO ADD SERVICES -------------------------------------------------

$routeToConfigService1 = $letterOfExtraible+$service1;
$routeToConfigService2 = $letterOfExtraible+$service2;



"Host github.com
    HostName github.com
    IdentityFile $routeToConfigService1
    User $userService1
Host gitlab.com
    HostName gitlab.com
    IdentityFile $routeToConfigService2 
    User $userService2
" | set-content TEMP-configPortable.txt -Encoding Ascii



#--------------------------------------------------------------------------------


cp TEMP-configPortable.txt $destinationInHome 

DEL infoExtraible.txt
DEL TEMP-configPortable.txt