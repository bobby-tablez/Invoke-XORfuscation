# Invoke-XORfuscation
![header image](https://raw.githubusercontent.com/bobby-tablez/Invoke-XORfuscation/main/banner.png?raw=true) 

Generate obfuscated PowerShell commands using XOR logic with random keys. Each variable as well as the XOR key is randomly generated. The resulting code is a PowerShell one-liner (or entire script) which contains a small function to deobfuscate the provided command or scriptblock.

In Command mode (C switch): Each time the scrript runs new function names will be created. When "S" is sllected after the first command generation, it will XORfuscate additional provided code using the last generated function. This is handy when multiple XORfuscated commands exist within the same scriptblock which will use only one function. 

In File mode (F switch): the script will read the contents of the file and will XORfuscate each line of the file and provide the obfuscated version of the file as output. Using this method, a single deobfuscation function is created and used to handle each obfuscated line of code. 

Example command: `whoami`:
```powershell
fuNctIoN ksu(${cv},${wm}){for($d=0;$d -lt ${cv}.couNt;$d++){${cv}[$d]=(${cv}[$d]-bxor${wm})}returN [SySteM.text.eNcodINg]::aScII.getStrINg(${cv})};${BTEk}=(&ksu([SySteM.byte[]]@(0xD9,0xC6,0xC1,0xCF,0xC3,0xC7))174);&(gal ?[?e]x)(${BTEk})
```
When prompted, specify a command to invoke. The script will continue obfuscating provided commands (Y/S) until (N) is provided.

## AV Bypass: AMSI
In this example a known AMSI bypass was used: [Amsi-Bypass-Powershell by S3cur3Th1sSh1t](https://github.com/S3cur3Th1sSh1t/Amsi-Bypass-Powershell)

When the code is placed into a .ps1 file (amsi.ps1) it is detected by Windows Defender (Dec. 2023). Running the code through Invoke-XORfucation (amsi_xorfuscated.ps1) allows it to execute thus bypassing Defender.
![XOR-AMSI-Bypass](https://raw.githubusercontent.com/bobby-tablez/Invoke-XORfuscation/main/Invoke_XORfuscation_AMSI_Bypass.png)


Use at your own risk! For educational purposes only.
