function Get-DesktopLocation {
    ## get the desktop location
    $DesktopPath = [Environment]::GetFolderPath("Desktop")
    return $DesktopPath
 }

 function Get-DesktopItemCount {
    ## get total sum of items on the desktop passed as integer
    $DesktopItemCount = 0
    $DesktopPath = Get-DesktopLocation
    Get-ChildItem -Path $DesktopPath -File |
    ForEach-Object {
        $DesktopItemCount += 1
}
    return $DesktopItemCount
 }

 function Show-DesktopFiles {
    $DesktopPath = Get-DesktopLocation
    Get-ChildItem -Path $DesktopPath -File |
    ForEach-Object {
        $File = $_.Name
        return $File
    }
 }