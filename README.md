# Invoke-XORfuscation
Generate obfuscated PowerShell commands using XOR logic with random keys. Each variable as well as the XOR key is randomly generated. The resulting code is a PowerShell one-liner which contains a small function to deobfuscate the provided command and XORfuscated code appened afterwards.

Each time the scrript runs new function names will be created, however, when prompted and "S" is sllected, it will use the same function names with random variables. This is handy when multiple XORfuscated commands exist within the same scriptblock which will use only one function. 

Example command: `whoami`:
```powershell
fuNctIoN ksu(${cv},${wm}){for($d=0;$d -lt ${cv}.couNt;$d++){${cv}[$d]=(${cv}[$d]-bxor${wm})}returN [SySteM.text.eNcodINg]::aScII.getStrINg(${cv})};${BTEk}=(&ksu([SySteM.byte[]]@(0xD9,0xC6,0xC1,0xCF,0xC3,0xC7))174);&(gal ?[?e]x)(${BTEk})
```
When prompted, specify a command to invoke. The script will continue obfuscating provided commands (Y/S) until (N) is provided.

Use at your own risk! For educational purposes only.
