# Normally redundant with OSSEC

cd $ENV:TEMP
Invoke-WebRequest -Uri https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-7.10.0-windows-x86_64.zip -OutFile winlogbeat-7.10.0-windows-x86_64.zip

    Download Winlogbeat

Expand-Archive .\winlogbeat-7.10.0-windows-x86_64.zip -DestinationPath .

    Unzip Winogbeat

mv .\winlogbeat-7.10.0-windows-x86_64 'C:\Program Files\winlogbeat'

    Move WInlogbeat to the Program Files directory

cd 'C:\Program Files\winlogbeat\'

    Change to the Program Files directory

Invoke-WebRequest -Uri https://raw.githubusercontent.com/CptOfEvilMinions/ChooseYourSIEMAdventure/main/conf/winlogbeat/winlogbeat.yml -OutFile winlogbeat.yml

    code Download Winglogbeat config

Using your favorite text editor open C:\Program Files\winlogbeat\winlogbeat.yml

    Open the document from the command line with Visual Studio Code: code .\winlogbeat.yml
    Open the document from the command line with Notepad: notepad.exe.\winlogbeat.yml

Scroll down to the output.logstash:

    Replace logstash_ip_addr
     with the IP address of FQDN of Logstash
    Replace logstash_port
     with the port Logstash uses to ingest Beats (default 5044)

powershell -Exec bypass -File .\install-service-winlogbeat.ps1
Set-Service -Name "winlogbeat" -StartupType automatic
Start-Service -Name "winlogbeat"
Get-Service -Name "winlogbeat"