# Invoke-XORfuscation
Generate obfuscated PowerShell commands using XOR logic with random keys. Each variable as well as the XOR key is randomly generated. The resulting code is a PowerShell one-liner which contains a small function to deobfuscate the provided command and XORfuscated code appened afterwards.

In Command mode (C switch): Each time the scrript runs new function names will be created. When "S" is sllected after the first command generation, it will XORfuscate additional provided code using the last generated function. This is handy when multiple XORfuscated commands exist within the same scriptblock which will use only one function. 

In File mode (F switch): the script will read the contents of the file and will XORfuscate each line of the file and provide the obfuscated version of the file. This is experimental and may not produce expected results, especially in the case of long command lines within the file. 

Example command: `whoami`:
```powershell
fuNctIoN ksu(${cv},${wm}){for($d=0;$d -lt ${cv}.couNt;$d++){${cv}[$d]=(${cv}[$d]-bxor${wm})}returN [SySteM.text.eNcodINg]::aScII.getStrINg(${cv})};${BTEk}=(&ksu([SySteM.byte[]]@(0xD9,0xC6,0xC1,0xCF,0xC3,0xC7))174);&(gal ?[?e]x)(${BTEk})
```
When prompted, specify a command to invoke. The script will continue obfuscating provided commands (Y/S) until (N) is provided.


Use at your own risk! For educational purposes only.
