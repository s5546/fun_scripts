:: Windows 10 has this really annoying feature where pushing F1 while file explorer's open opens a webpage in Edge
:: This tweak removes that!
:: Tested working on 1909
@echo off
taskkill /f /im HelpPane.exe
takeown /f %WinDir%\HelpPane.exe
icacls %WinDir%\HelpPane.exe /deny Everyone:(X) 