@echo off
REM Install .NET SDK (alleen nodig als nog niet geïnstalleerd)
echo Controleer of .NET SDK is geïnstalleerd...
dotnet --version || (
    echo Download en installeer .NET SDK 8...
    start https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-8.0.100-windows-x64-installer
    exit /b
)

REM Clone de repository
echo Clonen van EasyDevOps repository...
git clone https://github.com/Rickeggink/EasyDevOps.git

REM Run de frontend
echo Frontend uitvoeren...
cd EasyDevOps\frontend\EasyDevOps
dotnet run
pause
