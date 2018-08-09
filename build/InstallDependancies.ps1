[string[]]$PackageProviders = @('NuGet', 'PowerShellGet')
[string[]] $PowerShellModules = @('BuildHelpers', 'Pester', 'Posh-Git', 'PlatyPS', 'InvokeBuild', 'PSScriptAnalyzer')


# Line break for readability in AppVeyor console
Write-Host -Object ''

# Install package providers for PowerShell Modules
ForEach ($Provider in $PackageProviders) {
    If (!(Get-PackageProvider $Provider -ErrorAction SilentlyContinue)) {
        Install-PackageProvider $Provider -Force -ForceBootstrap -Scope CurrentUser
    }
}

# Install the PowerShell Modules
ForEach ($Module in $PowerShellModules) {
    If (!(Get-Module -ListAvailable $Module -ErrorAction SilentlyContinue)) {
        Install-Module $Module -Scope CurrentUser -Force -Repository PSGallery
    }
    Import-Module $Module
}
