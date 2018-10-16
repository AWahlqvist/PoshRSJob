﻿Function WriteStream {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$true)]
        [Object]$IndividualJob
    )
    Begin {
        $Streams = "Verbose","Warning","Error","Output","Debug"
    }

    Process {
        ForEach ($Stream in $Streams)
        {
            If (($IndividualJob.$Stream))
            {
                Switch ($Stream) {
                    "Verbose" { $IndividualJob | Select-Object -ExpandProperty Verbose| Where-Object { $_ } | ForEach-Object { Write-Verbose -Message $_ } }                    
                    "Debug"   { $IndividualJob | Select-Object -ExpandProperty Debug| Where-Object { $_ } | ForEach-Object { Write-Debug -Message $_ } }
                    "Warning" { $IndividualJob | Select-Object -ExpandProperty Warning| Where-Object { $_ } | ForEach-Object { Write-Warning -Message $_ } }
                    "Error"   { $IndividualJob | Select-Object -ExpandProperty Error | ForEach-Object { Write-Error -Message $_ } }
                    "Output"  { $IndividualJob | Where-Object { $_ } | Select-Object -ExpandProperty Output }
                }
            }

        }
    }
}