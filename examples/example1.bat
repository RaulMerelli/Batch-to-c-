@echo off
title Example
echo This is an example
pause > nul
set /p "input=Inserisci un numero: "
set /a input+=1
echo %input%
pause > nul
