#PostScript for SH-update#

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

$aibrepoUrl = "https://nxpwvdprodemeaaibreposa.blob.core.windows.net/aib-repository/"
$aibrepoSas = "?sv=2019-12-12&ss=b&srt=sco&sp=rl&se=2030-12-03T22:26:24Z&st=2020-12-03T14:26:24Z&spr=https&sig=Io6bNagCRnw3WyvfGOJWriTJlQ%2BIXg1BC%2FraTxPggQs%3D"

if ($null -eq (Get-Item -Path "c:\buildArtifacts" -ErrorAction SilentlyContinue)) {
    New-Item -Path "c:\buildArtifacts" -ItemType Directory -Force
}
$baseLocation = "c:\buildArtifacts"
Set-Location "c:\buildArtifacts"

$logFileLocation = "c:\buildArtifacts\Installation.log"

#Region FIT Intallation
"FIT" | Out-File $logFileLocation -Append
(Get-Date).ToString("o") | Out-File $logFileLocation -Append

$FITurl = ("{0}FIT.zip{1}" -f $aibrepoUrl, $aibrepoSas)
$FITzipLocation = "c:\buildArtifacts\FIT.zip"
$FITLocation = "c:\buildArtifacts\FIT9_Install_PRD.exe"

("Starting download FIT...") | Out-File $logFileLocation -Append
Write-Host ("Starting download FIT...")
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($FITurl, $FITzipLocation)
("Download finished.") | Out-File $logFileLocation -Append
Write-Host ("Download finished.")

Write-Host ("Starting extraction...")
Expand-Archive -Path $FITzipLocation -DestinationPath $baseLocation
Write-Host ("Extraction finished.")

("Starting FIT installer...") | Out-File $logFileLocation -Append
Write-Host ("Starting FIT installer...")
$FIT_install_status = Start-Process -FilePath $FITLocation -Wait -Passthru
("Installer finished with returncode '{0}'" -f $FIT_install_status.ExitCode) | Out-File $logFileLocation -Append
Write-Host ("Installer finished with returncode '{0}'" -f $FIT_install_status.ExitCode)

("Finished FIT installation...") | Out-File $logFileLocation -Append
(Get-Date).ToString("o") | Out-File $logFileLocation -Append
#endregion

#Region ForcepointDLP
"ForcepointDLP" | Out-File $logFileLocation -Append
(Get-Date).ToString("o") | Out-File $logFileLocation -Append

$ForcepointDLPurl = ("{0}ForcepointDLP.zip{1}" -f $aibrepoUrl, $aibrepoSas)
$ForcepointDLPzipLocation = "c:\buildArtifacts\ForcepointDLP.zip"
$ForcepointDLPLocation = "c:\buildArtifacts\FORCEPOINT-ONE-ENDPOINT-x64.exe"

("Starting download ForcepointDLP...") | Out-File $logFileLocation -Append
Write-Host ("Starting download ForcepointDLP...")
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($ForcepointDLPurl, $ForcepointDLPzipLocation)
("Download finished.") | Out-File $logFileLocation -Append
Write-Host ("Download finished.")

Write-Host ("Starting extraction...")
Expand-Archive -Path $ForcepointDLPzipLocation -DestinationPath $baseLocation
Write-Host ("Extraction finished.")

("Starting ForcepointDLP installer...") | Out-File $logFileLocation -Append
Write-Host ("Starting ForcepointDLP installer...")
$ForcepointDLP_install_status = Start-Process -FilePath $ForcepointDLPLocation /v"/qn /norestart" -Wait -Passthru
("Installer finished with returncode '{0}'" -f $ForcepointDLP_install_status.ExitCode) | Out-File $logFileLocation -Append
Write-Host ("Installer finished with returncode '{0}'" -f $ForcepointDLP_install_status.ExitCode)

("Finished ForcepointDLP installation...") | Out-File $logFileLocation -Append
(Get-Date).ToString("o") | Out-File $logFileLocation -Append
#endregion

#Region Crowd strike FalconSensor Windows
"FalconSensor_Windows" | Out-File $logFileLocation -Append
(Get-Date).ToString("o") | Out-File $logFileLocation -Append
$FalconSensor_Windowsurl = ("{0}FalconSensor_Windows.zip{1}" -f $aibrepoUrl, $aibrepoSas)
$FalconSensor_WindowszipLocation = "c:\buildArtifacts\FalconSensor_Windows.zip"
$FalconSensor_WindowsLocation = "c:\buildArtifacts\FalconSensor_Windows.exe"
("Starting download FalconSensor_Windows...") | Out-File $logFileLocation -Append
Write-Host ("Starting download FalconSensor_Windows...")
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($FalconSensor_Windowsurl, $FalconSensor_WindowszipLocation)
("Download finished.") | Out-File $logFileLocation -Append
Write-Host ("Download finished.")
Write-Host ("Starting extraction...")
Expand-Archive -Path $FalconSensor_WindowszipLocation -DestinationPath $baseLocation
Write-Host ("Extraction finished.")
("Starting FalconSensor_Windows installer...") | Out-File $logFileLocation -Append
Write-Host ("Starting FalconSensor_Windows installer...")
$FalconSensor_Windows_install_status = Start-Process -FilePath $FalconSensor_WindowsLocation -Argumentlist '/install /quiet /norestart CID=EC056755EE594F62A8B4A0295609A302-32' -PassThru
("Installer finished with returncode '{0}'" -f $FalconSensor_Windows_install_status.ExitCode) | Out-File $logFileLocation -Append
Write-Host ("Installer finished with returncode '{0}'" -f $FalconSensor_Windows_install_status.ExitCode)
("Finished FalconSensor_Windows installation...") | Out-File $logFileLocation -Append
(Get-Date).ToString("o") | Out-File $logFileLocation -Append

#endregion

