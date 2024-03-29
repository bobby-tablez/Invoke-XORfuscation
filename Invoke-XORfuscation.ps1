<# 
.SYNOPSIS
    Obfuscate code using XOR, then execute it.
.DESCRIPTION 
     A quick tool that generates uses a simple XOR function to ob fuscate code, then executes it using a few randomized obfuscted invoke expressions. The generated strings can be a bit lengthy so best to break up the commands into smaller ones and use the same function
.NOTES 
    Use at your own risk.
.LINK 
    https://raw.githubusercontent.com/bobby-tablez/Invoke-XORfuscation/main/Invoke-XORfuscation.ps1
#>

# Banner generation
$plain = "whoami" 
$mfctd = '"FunCTIOn puf(${tQ},${NM}){FOR($N=0;$N -LT ${tQ}.COunT;$N++){${tQ}[$N]=(${tQ}[$N]-bxOR${NM})}ReTuRn [sysTem.TexT.enCOdIng]::asCII.geTsTRIng(${tQ})};${qWgv}=(&puf([sysTem.byTe[]]@(0x80,0x9F,0x98,0x96,0x9A,0x9E))247);&(g`Cm [?x])(${qWgv})"'

foreach ($char in $plain.ToCharArray()) {
    Write-Host -NoNewline $char -ForegroundColor green
    Start-Sleep -Milliseconds (Get-Random -Minimum 50 -Maximum 120)
}
Write-Host ""
Write-Host  -NoNewline " == " -ForegroundColor red

foreach ($char in $mfctd.ToCharArray()) {
    Write-Host -NoNewline $char -ForegroundColor magenta
    Start-Sleep -Milliseconds (Get-Random -Minimum 1 -Maximum 4)
}
Write-Host "`n"


$global:randF = 0

# Build XORfucation strings
function enXor ($asciiString, $static) {
    $xorKey = Get-Random -Minimum 1 -Maximum 255
    $byteStream = [System.Text.Encoding]::ASCII.GetBytes($asciiString)
    $hexStream = @()

    # Random case generation. It's messy but works...
    $aA = @("a","A") | Get-Random;$aB = @("b","B") | Get-Random;$aC = @("c","C") | Get-Random;$aD = @("d","D") | Get-Random;$aE = @("e","E") | Get-Random;$aF = @("f","F") | Get-Random;$aG = @("g","G") | Get-Random;$aH = @("h","H") | Get-Random;$aI = @("i","I") | Get-Random;$aJ = @("j","J") | Get-Random;$aK = @("k","K") | Get-Random;$aL = @("l","L") | Get-Random;$aM = @("m","M") | Get-Random;$aN = @("n","N") | Get-Random;$aO = @("o","O") | Get-Random;$aP = @("p","P") | Get-Random;$aQ = @("q","Q") | Get-Random;$aR = @("r","R") | Get-Random;$aS = @("s","S") | Get-Random;$aT = @("t","T") | Get-Random;$aU = @("u","U") | Get-Random;$aV = @("v","V") | Get-Random;$aW = @("w","W") | Get-Random;$aX = @("x","X") | Get-Random;$aY = @("y","Y") | Get-Random;$aZ = @("z","Z") | Get-Random
    
    # Generate random variables and invokes
    $randEnc = -join ((65..90) + (97..122) | Get-Random -Count 4 | % {[char]$_})
    $randX = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {[char]$_})
    $randB = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {[char]$_})

    if ($static  -eq "0") {
        $global:randF = -join ((65..90) + (97..122) | Get-Random -Count 3 | % {[char]$_})
    }

    $randS = -join ((65..90) + (97..122) | Get-Random -Count 1 | % {[char]$_})   
    $invokes = @("($aG$aA``$aL ?[?$aE]$aX)","($aG$aC``$aM ?[?$aE]$aX)","($aG``$aC$aM ?[?$aE]$aX)","($aG$aA``$aL ?$aE[?$aX])","($aG``$aC$aM ?$aE[?$aX])","(``$aG$aA``$aL $aI`?[?$aX])","($aG``$aC$aM $aI`?[?$aX])")
    
    for ($i = 0; $i -lt $byteStream.count; $i++) {
       $hexStream += '0x' + '{0:X}' -f ($byteStream[$i] -bxor $xorKey)
    } 
    
    # Build strings (new function)
    if ($static  -eq "0") {
        $finFun = "$aF$aU$aN$aC$aT$aI$aO$aN " + $randF + '(${' + $randB + '},${' + $randX + "}){$aF$aO$aR($" + $randS + '=0;$' + $randS + " -$aL$aT `${" + $randB + "}.$aC$aO$aU$aN$aT;`$" + $randS + '++){${' + $randB + '}[$' + $randS + ']=(${' + $randB + '}[$' + $randS + "]-$aB$aX$aO$aR`${" + $randX + "})}$aR$aE$aT$aU$aR$aN [$aS$aY$aS$aT$aE$aM.$aT$aE$aX$aT.$aE$aN$aC$aO$aD$aI$aN$aG]::$aA$aS$aC$aI$aI.$aG$aE$aT$aS$aT$aR$aI$aN$aG(`${" + $randB + '})};'
    }

    $finCmd = '${' + $randEnc + '}=(&' + $randF + "([$aS$aY$aS$aT$aE$aM.$aB$aY$aT$aE[]]@(" + (($hexStream) -join",") +"))" + $xorKey + ');&' + (Get-Random -InputObject $invokes) + '(${' + $randEnc + '})'
    $finFin = $finFun + $finCmd

    return $finFin
}

# Build obfuscated/randomized version of: $erroractionpreference = "SilentlyContinue"
Function SuppressErrors {
    $plus = @('''+''','')
    $tick = @('`','')
    $SilentVar = "`${e" + (Get-Random $tick) + "R" + (Get-Random $tick) + "R" + (Get-Random $tick) + "O" + (Get-Random $tick) + "Rac" + (Get-Random $tick) + "Ti" + (Get-Random $tick) + "O" + (Get-Random $tick) + "Np" + (Get-Random $tick) + "R" + (Get-Random $tick) + "E" + (Get-Random $tick) + "F" + (Get-Random $tick) + "E" + (Get-Random $tick) + "R" + (Get-Random $tick) + "e" + (Get-Random $tick) + "Nc" + (Get-Random $tick) + "e}='S" + (Get-Random $plus) + "i" + (Get-Random $plus) + "l" + (Get-Random $plus) + "e" + (Get-Random $plus) + "n" + (Get-Random $plus) + "t" + (Get-Random $plus) + "l" + (Get-Random $plus) + "y" + (Get-Random $plus) + "C" + (Get-Random $plus) + "o" + (Get-Random $plus) + "n" + (Get-Random $plus) + "t" + (Get-Random $plus) + "i" + (Get-Random $plus) + "n" + (Get-Random $plus) + "u" + (Get-Random $plus) + "e'"
    
    return $SilentVar
}

# Read in file and process it

Function ProcessFile ($filePath) {

    $fileContent = Get-Content $filePath
    $varArray = @()
    $sta = "0"

    for($i = 0; $i -lt $fileContent.Count; $i++) {
        if ([string]::IsNullOrWhiteSpace($fileContent[$i])) {
            continue
        }
        $varArray += ,(&enXor $fileContent[$i] $sta)
        $sta = "1"
    }

    # Check if file has more than 100 lines
    if ($fileContent.Count -gt 100) {

        # File construction/definitions
        $fileDirectory = [System.IO.Path]::GetDirectoryName($filePath)
        $fileName = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
        $fileExtension = [System.IO.Path]::GetExtension($filePath)
        $newFilePath = Join-Path $fileDirectory "$fileName`_XOR$fileExtension"

        # Prepend ErrorAction function to varArray
        $varArray = @(SuppressErrors) + $varArray

        # Save processed content to newly created file
        $varArray | Out-File -FilePath $newFilePath -Encoding UTF8

        return "File saved as $newFilePath"

    } else {
        
        Write-Host -ForegroundColor Yellow @(SuppressErrors)
        return $varArray
    }
}


# Build menu structure
Do{
    # Main menu
    $start = Read-Host "XORfuscate file or command? [F = File, C = Command, Q = Quit]"
    
    # Command options
    If ($start -eq "C"){
        Do{
            $sta = "0"
            $input = Read-Host -Prompt 'Provide command to XORfuscate (new function)'
            $result = &enXor $input $sta

            Write-Host -ForegroundColor Yellow $result
            Write-Host ""

            $restartSame = Read-host "Do you want to XORfuscate another command? [Y/N], or another under the same function? (S)"
            
            # Keep outputting commands under the same function name
            While ($restartSame -eq "S"){
                $sta = "1" # Used to signal function generation on/off
                $input = Read-Host -Prompt 'Provide command to XORfuscate (same function)'
                $result = &enXor $input $sta

                Write-Host -f DarkYellow $result
                Write-Host ""

                $restartSame = Read-host "Another under the last generated function? [Back: B] [Another: S]"
            }
        

        }Until(($restartSame -eq "N") -or ($restartSame -eq "B"))
    }

    # File options
    If ($start -eq "F"){
        
        $filePath = Read-Host -Prompt 'File to XORfuscate'
            
        If (Test-Path -Path $filePath) {
            
            Write-Host ""

            $result = ProcessFile $filePath
            
            foreach ($var in $result) {
                Write-Host -ForegroundColor Yellow $var
            }
            Write-Host ""
            
        } else {
            Write-Host -ForegroundColor Red "File not found at $filePath"
        }
        
    }
    If (($start -eq "F") -or ($restartSame -eq "N") -or ($restartSame -eq "B")){
        # Do Nothing
    }
    Else{
        Write-Host -ForegroundColor Red "Invalid input. [F/C/Q]?"
    }
}Until($start -eq "Q")

Write-Host -ForegroundColor "Green" "Bye!"
