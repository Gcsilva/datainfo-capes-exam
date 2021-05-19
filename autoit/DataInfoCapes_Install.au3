#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:         Gcsilva (gc.silva@gmail.com)

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <GUIConstants.au3>
#include "constants.au3"
#include <MsgBoxConstants.au3>
#include <Array.au3>

#AutoIt3Wrapper_Icon=icons\icon.ico

$projeto_title = "Datainfo & Capes"
$WorkingDir = StringSplit(@WorkingDir, '\')
$projeto_name = $WorkingDir[UBound($WorkingDir) -1]

$msg =  "Vamos instalar o projeto " & $projeto_title & "?" & @CRLF & @CRLF
$msg &= "Iremos realizar as seguintes operações: " & @CRLF & @CRLF
$msg &= "    - docker-compose up" & @CRLF
$msg &= "    - compose update" & @CRLF
$msg &= "    - criar schema na base dados (mysql)" & @CRLF
$msg &= "    - executar as migrates" & @CRLF

ConsoleWrite($msg)

$rs = MsgBox($MB_YESNO, $projeto_title, $msg)
If($rs == $IDYES) Then
   ExecAll()
   MsgBox (0, $projeto_title, "O sistema Datainfo Capes Test Exeam foi instalado.")
Else
   MsgBox (0, $projeto_title, "Volte sempre. Obrigado!")
EndIf

Func ExecAll()
   CreateContainers()

   Local $commands[5]
   $commands[0] = " cd /var/www/html "
   $commands[1] = " cp vhost.txt /etc/apache2/sites-enabled/000-default.conf "
   $commands[2] = " composer update "
   $commands[3] = " mysql -h mysql8_capes -u root -p\""root\"" -e \""CREATE DATABASE datainfo_capes\"" "
   $commands[4] = " php artisan migrate "

   $cmd = _ArrayToString($commands, " && ")

   $command = "docker exec -it php8_capes sh -c "" " & $cmd & " "" "

   ConsoleWrite($command)

   ExecuteCommand($command)
   ExecuteCommand("docker restart php8_capes")

   OpenBrowser()
EndFunc

Func CreateContainers()
   ExecuteCommand("docker-compose -f Docker-compose.yml up -d --build")
EndFunc

Func OpenBrowser()
   $Url = "http://localhost:8081"
   $OpenUrl = RegRead ("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Applications\chrome.exe\shell\open\command", ""); Get the Internet browser path
   $PosParam    = StringInStr ($OpenUrl, "%")         ; Parameter location (%l)
   $OpenUrlLeft  = StringLeft  ($OpenUrl, $PosParam-1)   ; Left handside of the path
   $OpenUrlRight = StringMid   ($OpenUrl, $PosParam+2,999); Right handside of the path
   Run ($OpenUrlLeft & $url & $OpenUrlRight)
EndFunc

Func ExecuteCommand($command)
   $iPID = RunWait($command , "" , @SW_SHOW)
   return $iPID
EndFunc



