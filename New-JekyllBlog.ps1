<# 
 .Synopsis
  Creates a new Jekyll blog.

 .Description
  Creates a new Jekyll blog.
 
 .Parameter Path
  Path to create the blog at. If left blank current directory is used.

 .Example
  cd c:\blogs\MyNewBlog
  New-JekyllBlog

 .Example
  New-JekyllBlog c:\blogs\MyNewBlog
#>
function New-JekyllBlog {
    param([string]$path=".")

    $oldPath = $env:path
    $PathUpdate = $env:path += ";$PSScriptRoot\Jekyll-Portable\ruby\bin;$PSScriptRoot\Jekyll-Portable\devkit\bin;$PSScriptRoot\Jekyll-Portable\git\bin;$PSScriptRoot\Jekyll-Portable\Python\App;$PSScriptRoot\Jekyll-Portable\devkit\mingw\bin;$PSScriptRoot\Jekyll-Portable\curl\bin;" 
    $env:path = $PathUpdate
    &jekyll.bat new $path
    $env:path = $oldPath 
}

Export-ModuleMember New-JekyllBlog