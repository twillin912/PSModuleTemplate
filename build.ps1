[CmdletBinding()]
param (
    [ValidateSet('Init','Build','Help','Pester','Test')]
    [string] $Task
)

# Line break for readability in AppVeyor console
Write-Host -Object ''

. (Join-Path -Path $PSScriptRoot -ChildPath 'build/InstallDependancies.ps1' -Resolve)

Set-BuildEnvironment -Force

Get-Item -Path "env:*"

if ($Task -eq 'Init') {
    return
}
#Invoke-Build -Task $Task

if ($Task -eq 'Pester') {
    Invoke-Pester -Script (Join-Path -Path $env:BHProjectPath -ChildPath 'tests')
}
