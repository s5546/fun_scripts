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


echo -----------Extract UPKs-----------
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

echo -----------Scan extracted files for OGG files contained within-----------
echo Scanning extracted files for OGGs... Keep an eye on your powershell instances in Task Manager: 
echo There should be an instance using a high amount of CPU time, using a some HDD time, and slowly gaining memory.
echo This instance first recursively scans extractedUPKs/, and then runs oggextract.exe on all found files.
echo This could take an OUTRAGEOUSLY long time depending on how many UPKs you extracted. Be patient pls
echo If you've extracted the entire game, this could take on the order of DAYS. Just the recursive 
echo  directory listing takes up about 400MB of space, with just under 3 million unique lines.
echo (i have no idea why it takes this long- even just running that command only takes about 20 minutes)
echo (if you know why, please fix my code and i'll update the repo)
echo 
echo If you don't need the OGGs, feel free to kill this process- the assets are already extracted.
SET count=1
 FOR /f "tokens=*" %%G IN ('dir /b /s extractedUPKs') DO (
 echo Now scanning %%~nG...
 oggextract.exe "%%~fG" 2> nul
 echo '%%~fG.ogg'
 mv '%%~fG_0000009c.ogg' 'E:\LW mods\decompressUPK\FinalSoundOggs'
 set /a count+=1 )
pause