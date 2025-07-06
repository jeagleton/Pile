# binobj-clean.ps1
param(
    [switch]$Delete
)

# Determine if delete should occur
$doDelete = $Delete -or $d

Get-ChildItem -Path . -Recurse -Filter *.csproj | ForEach-Object {
    $projectDir = $_.DirectoryName
    @('bin', 'obj') | ForEach-Object {
        $targetFolder = Join-Path $projectDir $_
        if (Test-Path $targetFolder) {
            Get-ChildItem -Path $targetFolder -Recurse -File | ForEach-Object {
                if ($doDelete) {
                    Remove-Item $_.FullName -Force
                } else {
                    Write-Output $_.FullName
                }
            }
        }
    }
}