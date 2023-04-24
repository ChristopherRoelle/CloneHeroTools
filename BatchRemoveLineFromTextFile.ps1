# Author : Christopher Roelle
# Date   : 04-23-2023
# Purpose: Updates ini file to batch remove a line from all files.

$pathOfCloneHeroSongs = 'C:\Users\chris\Desktop\CloneHeroScriptTest'
$fileFilter = 'song.ini'
$lineToRemovePattern = 'playlist_track'

$filesUpdatedCount = 0
$filesSkippedCount = 0

Get-ChildItem -Path $pathOfCloneHeroSongs -Filter $fileFilter -Recurse|
ForEach-Object{

    $updatedFlag = 0
    
    Write-Output('File found: ' + $_.Name)
    Write-Output('Path: ' + $_.FullName)
    
    $fileContents = Get-Content -Path $_.FullName

    forEach($line in $fileContents)
    {

        if($line -match $lineToRemovePattern)
        {
            Write-Output('Found line matching pattern.')
            Write-Output('Removing.')
            $fileContents = $fileContents.replace($line, "")
            $filesUpdatedCount++
            $updatedFlag = 1
        }
    }

    #Set the file to the updated fileContents
    if($updatedFlag -eq 1)
    {
        Write-Output('Writing changes to file...')

        #Only write non-empty elements
        $fileContents.Where({$_ -ne ""}) | Set-Content -Path $_.FullName

        Write-Output('Done!')
    }
    else
    {
        Write-Output($_.Name + ' did not contain the pattern. Skipping.')
        $filesSkippedCount++
    }

    Write-Output('')
}

Write-Output('Processing complete!')
Write-Output('Files updated: ' + $filesUpdatedCount)
Write-Output('Files skipped: ' + $filesSkippedCount)