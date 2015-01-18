<# 
 .Synopsis
  Displays the output from the Jekyll server.

 .Description
  Displays the output from the Jekyll server till you press ctrl + c.

  Note: Pressing crtl + c will not terminate the server, you must use Stop-JekyllServer.
 
 .INPUTS
  Jekyll server object to disaply output from.

 .Example
   Get-JekyllServer | where name -eq MyBlog | Watch-JekyllServer
#>
function Watch-JekyllServer {
    param([Parameter(ValueFromPipeline=$true, Position=0, ValueFromPipelineByPropertyName=$false, Mandatory=$true)]$Object)

    Receive-Job -Job $Object.Job -Wait

}

Export-ModuleMember Watch-JekyllServer