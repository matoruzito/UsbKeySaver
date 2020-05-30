## STAGE01 here you set your pendrive name. 

$pendriveName = "K-MSM-00";

##--------------------------------------------------------------------------------------------

## STAGE02 here you set your keys locations inside the pendrive. One per service.

$service1 = ":/.ssh/githubKey";

##--------------------------------------------------------------------------------------------

## STAGE03 here you set your usernames for the correlative services.

$userService1 = "John Doe";

##--------------------------------------------------------------------------------------------

## STAGE04 here you set your home ssh client directory. 

$destinationInHome = "~/.ssh/config";

##--------------------------------------------------------------------------------------------

## STAGE05 here the script finds the identifier of your pendrive, bassed on your pendriveName. 
## You do not need to change anything here.

Get-WmiObject -Class Win32_logicaldisk  | Where-Object VolumeName -EQ $pendriveName  | Select-Object  "DeviceId" > infoExtraible.txt;

$i = 0
$contentByLines = ""
foreach($line in Get-Content .\infoExtraible.txt) {
       
       $contentByLines += $line;
       
       $i++;
}

$letterOfExtraible = $contentByLines[16]; #Identifier of Pendrive or extraible flash unit

##--------------------------------------------------------------------------------------------

## STAGE06 here you add services complete routes, as it is shown with the first:

$routeToConfigService1 = $letterOfExtraible+$service1;

##--------------------------------------------------------------------------------------------

## STAGE07 here is how it will look your client-config ssh file, edit by adding your services.

"Host github.com
    HostName github.com
    IdentityFile $routeToConfigService1
    User $userService1
" | set-content TEMP-configPortable.txt -Encoding Ascii

##--------------------------------------------------------------------------------------------

## STAGE08 here you do not need to change anything. 

cp TEMP-configPortable.txt $destinationInHome 

DEL infoExtraible.txt
DEL TEMP-configPortable.txt

##--------------------------------------------------------------------------------------------
