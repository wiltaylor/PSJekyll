# PSJekyll
Simple powershell module for interacting with Jekyll.

## Requirements:
  Powershell 4.0 (Tested on windows 8.1)

## Installation
 - Extract the module into the a Jekyll folder in your modules directory (e.g. %userprofile%\documents\WindowsPowerShell\Modules\Jekyll)
 - Download [Portable Jekyll](https://github.com/madhur/PortableJekyll) and place it in a folder called Jekyll-Portable in the folder jekyll module folder created above.
 
## Usage
Simply load the module with Import-Module Jekyll.

All cmdlet's have full help so use get-help on them.

Cmdlets:
 - Get-JekyllServer
 - New-JekyllBlog
 - Reset-JekyllServer
 - Start-JekyllServer
 - Stop-JekyllServer
 - Watch-JekyllServer

## License 
This module is licensed under MIT License. See LICENSE file in root of repository for more details.

## Contact Details:
Author: Wil Taylor (wil@win32.io)
