<# 
 .Synopsis
  Restarts a Jekyll Server

 .Description
  Terminates existing Jekyll Server and starts a new one with the same properties.

 .INPUTS
  Pass in Jekyll server object to restart.

 .OUPUTS
  New Jekyll server object.

 .Example
   $MyBlog = $MyBlog | Reset-JekyllServer
#>
function Reset-JekyllServer {
    param([Parameter(ValueFromPipeline=$true, Position=0, ValueFromPipelineByPropertyName=$false, Mandatory=$true)]$Object)

    $para = @{
        Name = $Object.Name;
        Path = $Object.Path;
        Port = $Object.Port;
        Drafts = $Object.Drafts;
        Future = $Object.Future;
        NoWatch = $Object.NoWatch;
        BuildOnly = $false
    }

    $Object | Stop-JekyllServer

    Start-JekyllServer @para
}

Export-ModuleMember Reset-JekyllServer