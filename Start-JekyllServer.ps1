<# 
 .Synopsis
  Starts a JekyllServer

 .Description
  Starts a Jekyll Server in target directory as a background job. If you wish to see the server console output see Watch-JekllServer cmdlet.
 
 .Parameter Name
  Name of the Jekyll Server session. This is to identify the server when using Get-JekyllServer.

 .Parameter Path
  Location of Jekyll instance to serve.

 .Parameter Port
  Port Jekyll server will serve http from.

 .Parameter Drafts
  Jekyll server will also include documents in _draft folder. See Jekyll documentation for more details.

 .Parameter Future
  Jekyll server will also include posts marked in the future. See Jekyll documentation for more details. 

 .Parameter NoWatch
  This switch instructs the Jekyll server to not watch for file system changes.
 
 .Parameter BuildOnly
  This switch will cause Jekyll to build static content but not serve it via http.

 .Example
  # Starts JekyllServer using the current directory as the path.
  Start-JekyllServer

 .Example
  # Starts JekyllServer using a path and port. Also uses all Future and Draft posts.
  Start-JekyllServer -Name MyBlog -Path c:\blog\MyBlog -Port 5000 -Drafts -Future

 .Example
  # Starts JekyllServer without watching the file system.
  Start-JekyllServer -Name MyBlog -NoWatch

 .Example
  # Builds static content.
  Start-JekyllServer -Path c:\blog\MyBlog -BuildOnly 
#>
function Start-JekyllServer {

    param([string]$Name="", [string]$Path=(Get-Location), [int]$Port=0, [switch]$Drafts, [switch]$Future, [switch]$NoWatch, [switch]$BuildOnly)

    $oldPath = $env:path
    $PathUpdate = $env:path += ";$PSScriptRoot\Jekyll-Portable\ruby\bin;$PSScriptRoot\Jekyll-Portable\devkit\bin;$PSScriptRoot\Jekyll-Portable\git\bin;$PSScriptRoot\Jekyll-Portable\Python\App;$PSScriptRoot\Jekyll-Portable\devkit\mingw\bin;$PSScriptRoot\Jekyll-Portable\curl\bin;"
    
    if($BuildOnly) {
        $env:path = $PathUpdate
        $currentdir = Get-Location
        cd $Path
        &jekyll.bat build
        cd $currentdir
        $env:path = $oldPath 
    }else{
        
        if($Name -eq "") { $Name = Split-Path (Resolve-Path $Path) -Leaf }

        $command = "&jekyll.bat serve "

        if($Drafts) { $command += "--drafts " }
        if($Future) { $command += "--future " }
        if($NoWatch) {$command += "--no-watch " }

        if($Port -ne 0) {
            $command += "--port $Port "
        }

        $jobdetails = New-Object PSObject
        $jobdetails | Add-Member -MemberType NoteProperty -Name Name -Value $Name
        $jobdetails | Add-Member -MemberType NoteProperty -Name Path -Value $Path
        $jobdetails | Add-Member -MemberType NoteProperty -Name Port -Value $Port
        $jobdetails | Add-Member -MemberType NoteProperty -Name Drafts -Value $Drafts
        $jobdetails | Add-Member -MemberType NoteProperty -Name Future -Value $Future
        $jobdetails | Add-Member -MemberType NoteProperty -Name NoWatch -Value $NoWatch
        $jobdetails | Add-Member -MemberType NoteProperty -Name Job -Value $null
        $jobdetails | Add-Member -MemberType ScriptProperty -Name State -Value {
            $this.Job.State
        }

        $jobdetails.Job = Start-Job -Name $Name -ArgumentList @($PathUpdate, $Path, $command) -ScriptBlock { 
            $args
            $env:path += $args[0]
            cd $args[1]
            Invoke-Expression $args[2] 
        }

        $Script:jekylljobs += $jobdetails

        $jobdetails
    }
}

Export-ModuleMember Start-JekyllServer