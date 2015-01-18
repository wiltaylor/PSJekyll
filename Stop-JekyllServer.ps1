<# 
 .Synopsis
  Stops Jekyll Servers.

 .Description
  Stops Jekyll Servers.
 
 .Parameter All
  Terminates all running Jekyll servers.

 .INPUTS
  Jekyll server objects to stop.

 .Example
  Stop-JekyllServer -All

 .Example
  Get-JekyllServer | where Name -eq MyBlog | Stop-JekyllServer
#>
function Stop-JekyllServer {
    [CmdletBinding()]
    param([switch]$All, [Parameter(ValueFromPipeline=$true, Position=0, ValueFromPipelineByPropertyName=$false)]$object)

    begin {
        if($All) {
            foreach($obj in $Script:jekylljobs) {
                Stop-Job $obj.Job | Out-Null
                Remove-Job $obj.Job | Out-Null
            }

            $Script:jekylljobs = @()
            return
        }
    }

    process{
        if($_ -eq $null) { return }
        if($_.Job -eq $null) { return }
        Stop-Job $_.Job | Out-Null
        Remove-Job $_.Job | Out-Null
        $Script:jekylljobs = $Script:jekylljobs -ne $_
    }
}

Export-ModuleMember Stop-JekyllServer