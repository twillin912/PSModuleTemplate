Describe ('General Project Validation: {0}' -f $env:BHProjectName) {
    $ScriptFiles = Get-ChildItem -Path "$env:BHPSModulePath" -Include *.ps1, *.psd1, *.psm1 -Recurse
    $TestCases = $ScriptFiles | ForEach-Object {
        @{
            FileName = $_.FullName.Replace("$($env:BHPSModulePath)\", "")
            FilePath = $_.FullName
        }
    }

    It 'Script <FileName> should be valid powershell' -TestCases $TestCases {
        param ($FileName, $FilePath)

        $FilePath | Should Exist

        $Content = Get-Content -Path $FilePath -ErrorAction Stop
        $Errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize(
            $Content, [ref]$Errors
        )
        $Errors.Count | Should Be 0
    }

    It ('Module {0} can import cleanly' -f $env:BHProjectName) {
        { Import-Module -Name $env:BHPSModuleManifest -Force } | Should Not Throw
    }
}
