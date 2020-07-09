@echo off

REM This script extracts UPKs, and then scans through the extracted contents for OGG files.
REM Originally created to extract X-COM: EW's assets, for use in a doom mod (msg me for info).
REM Expects a directory structure and files as follows:
REM 1) Folder "allUPKs" (containing all UPKs you intend to extract)
REM 2) Folder "extractedUPKs" (where the contents of all UPKs will be placed)
REM 3) Folder "FinalSoundOggs" (where any .OGG files found will be placed)
REM 4) Program "extract.exe" (the Unreal Package Extractor, downloaded from https://www.gildor.org/downloads)
REM 5) Program "oggextract.exe" (a program that parses all files for embedded OGGs, downloaded from https://moriya.ca/oggextract/)

echo -----------IMPORTANT-----------
echo If you intend to use the OGG extracting feature of this program, change the mv command's second argument 
echo ('E:\LW mods\decompressUPK\FinalSoundOggs') to your path to the 'FinalSoundOggs' folder-
echo I dont remember why I needed an absolute path but I'm sure it didnt work otherwise


REM -----------Extract UPKs-----------
echo Extracting files from UPKs...
SET count=1
FOR /f "tokens=*" %%G IN ('dir /b /s allUPKs') DO (
IF EXIST "extractedUPKs\%%~nG" (
echo File exists, passing...
) ELSE (
echo Extracting %%G
extract.exe "%%G" -out=extractedUPKs\
)
set /a count+=1 )

REM -----------Scan extracted files for OGG files contained within-----------
echo Scanning extracted files for OGGs... Keep an eye on your powershell instances in Task Manager: 
echo There should be an instance using a high amount of CPU time, using a some HDD time, and slowly gaining memory.
echo This instance first recursively scans extractedUPKs/, and then runs oggextract.exe on all found files.
echo This could take an OUTRAGEOUSLY long time depending on how many UPKs you extracted. Be patient pls
echo If you're extracting the entire game, this could take on the order of DAYS.
echo (for me, this took over two days of sitting at this prompt, waiting.)
echo (i have no idea why it takes this long, so feel free to fix my code lmao)
echo (Its the recursive directory listing that takes forever- theres a lot but i dont think there's 2 days worth)
SET count=1
 FOR /f "tokens=*" %%G IN ('dir /b /s extractedUPKs') DO (
 echo Now scanning %%~nG...
 oggextract.exe "%%~fG" 2> nul
 echo '%%~fG.ogg'
 mv '%%~fG_0000009c.ogg' 'E:\LW mods\decompressUPK\FinalSoundOggs'
 set /a count+=1 )
pause