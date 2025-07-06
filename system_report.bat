@echo off
setlocal EnableDelayedExpansion

set "OUTPUT=system_report.txt"

rem Create or overwrite the report file
(echo System report generated on %DATE% %TIME%) > "%OUTPUT%"

rem -------------------- Operating System --------------------
echo ==== Operating System ====>> "%OUTPUT%"
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type" >> "%OUTPUT%"

rem -------------------- Network Adapters --------------------
echo ==== Network Adapters ====>> "%OUTPUT%"
wmic nic where (NetEnabled=TRUE) get Name,Manufacturer,DriverVersion /format:table >> "%OUTPUT%"

rem -------------------- Wi-Fi Drivers --------------------
netsh wlan show drivers >> "%OUTPUT%" 2>NUL

rem -------------------- Group Policy Summary --------------------
echo ==== Group Policy Summary ====>> "%OUTPUT%"
if exist "%SystemRoot%\System32\gpresult.exe" (
    gpresult /R >> "%OUTPUT%"
) else (
    echo gpresult not available on this system>> "%OUTPUT%"
)

rem -------------------- Installed Antivirus --------------------
echo ==== Installed Antivirus ====>> "%OUTPUT%"
wmic /namespace:\\root\SecurityCenter2 path AntiVirusProduct get displayName,productState,pathToSignedProductExe /format:table >> "%OUTPUT%" 2>NUL

rem Inform user where the report was saved
echo Report saved to %OUTPUT%

endlocal
pause
