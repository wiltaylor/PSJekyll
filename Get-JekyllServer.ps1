<# 
 .Synopsis
  Gets all running Jekyll Servers.

 .Description
  Gets all running Jekyll Servers that have been started in this session of powershell.
 
 .OUTPUTS
  Returns Jekyll Server objects for all servers currently running.

 .Example
   Get-JekyllServer

 .Example
  #Get server named MyBlog
  Get-JekyllServer | where Name -eq MyBlog
#>
function Get-JekyllServer {
    $Script:jekylljobs
}

Export-ModuleMember Get-JekyllServer