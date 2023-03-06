# Author : Christopher Roelle
# Date   : 03-05-2023
# Purpose: Renames song videos in Clone Hero directories to fit the 
#          video.webm convention that CH looks for.

$pathOfCloneHeroSongs = 'E:\Clone Hero\Clone Hero_Data\StreamingAssets\songs\'
$videoFilter = '*.webm'
$renameTo = 'video.webm'

$renameCount = 0
$skipCount = 0

Get-ChildItem -Path $pathOfCloneHeroSongs -Filter $videoFilter -Recurse|
ForEach-Object{
    
    Write-Output('Video found: ' + $_.Name)
    Write-Output('Path: ' + $_.FullName)
    if($_.Name -ne $renameTo)
    {
        Rename-Item -Path $_.FullName -NewName $renameTo
        $renameCount += 1
        Write-Output('File renamed.')
    } else 
    {
        Write-Output('File already matches. No action.')
        $skipCount += 1
    }

    Write-Output('')
}

Write-Output('Processing complete!')
Write-Output('Videos renamed: ' + $renameCount)
Write-Output('Videos skipped: ' + $skipCount)
