@echo off
setlocal enableDelayedExpansion
chcp 65001
cls
set program_version=0.0.0.06
title BATCH TO C++ %program_version%
set output_name=file
set extension=.cpp
set output=%output_name%%extension%
if "%~s1"=="" goto stop
if exist %output% del %output%
echo #include ^<iostream^> >>%output%
echo #include ^<stdlib.h^> >>%output%
echo. >>%output%
echo using namespace std; >>%output%
echo. >>%output%
echo int main^(^)^{ >>%output%
echo. >>%output%
set percent=%%%

REM RIGHE


Set File=%~s1

findstr /v /r /c:"^$" /c:"^\ *$" /c:"^\	*$" "%File%" >> "temp.bat"
set OriginalFile=%File%
set File=temp.bat

call :Conta %File% ris
echo FILE: %OriginalFile%
echo TOTALE RIGHE: %Ris%
if "%Ris%"=="1" goto stop
echo premi qualsiasi tasto per avviare l'analisi.
pause >nul
echo.
echo ------------
echo  DEBUG MODE 
echo ------------
echo.
echo.
set riga_number=2
set skip_number=1
:loop1
set riga=riga%riga_number%

for /F "skip=%skip_number% delims=" %%i in (%File%) do if not defined riga%riga_number% set "riga%riga_number%=%%i"
echo riga%riga_number% !riga%riga_number%!
set /a riga_number2=%riga_number%+1
set /a skip_number2=%skip_number%+1
set riga_number=%riga_number2%
set skip_number=%skip_number2%
if "%Ris%"=="%skip_number%" goto endloop1
goto loop1
:endloop1

REM PAROLE

set numero_ripetizione=1
:numero_ripetizione
set sentence=!riga%numero_ripetizione%!
echo.
echo RIGA%numero_ripetizione%:
set round=0
set countcheck=0
echo %sentence%
REM LA STRINGA SEGUENTE SERVE PER PREVENIRE CRASH CON I SET /P
if "!sentence:~0,6!"=="set /p" goto skip_goto_total

if "%sentence%"=="" (
echo. >>%output%
goto total
)

:skip_goto_total
echo skip goto total
set old_sentence=%sentence%
:str_check

REM CONTATORE DI LETTERE
:retry_count
if "!sentence:~%countcheck%,100!"=="" goto stop_count
set /a countcheck += 1
goto retry_count
:stop_count

echo numero caratteri=%countcheck%
set sentence=%old_sentence%
set countchar=%countcheck%

set countcheck=0
set round=1
set space=0

:count_words
if "!sentence:~%countcheck%,1!"==" " goto space_found
goto skip_space_found

:space_found
set /a long=%countcheck%-%space%
if not "!sentence:~%space%,%long%!"=="" echo parola trovata da %space% a %countcheck%: !sentence:~%space%,%long%!

REM //////////////////////////////////////
REM /////////// PAUSE ////////////////////
REM //////////////////////////////////////
if "!sentence:~%space%,%long%!"=="pause" (echo comando pause trovato
echo system ^("!riga%numero_ripetizione%!"^); >>%output%)

REM //////////////////////////////////////
REM /////////// START ////////////////////
REM //////////////////////////////////////
if "!sentence:~%space%,%long%!"=="start" goto start_command_found
if "!sentence:~%space%,%long%!"=="Start" goto start_command_found
if "!sentence:~%space%,%long%!"=="START" goto start_command_found
goto skip_start
:start_command_found
echo comando start trovato
set /a space_new=%space%+6
echo !sentence:~%space_new%,4! con spacenew a %space_new%
if "!sentence:~%space_new%,4!"=="http" echo system ^("!riga%numero_ripetizione%!"^); >>%output%
:skip_start

REM //////////////////////////////////////
REM /////////// EXIT /////////////////////
REM //////////////////////////////////////
if "!sentence:~%space%,%long%!"=="exit" (echo comando exit trovato
echo system ^("!riga%numero_ripetizione%!"^); >>%output%)

REM //////////////////////////////////////
REM /////////// REM //////////////////////
REM //////////////////////////////////////
if "!sentence:~%space%,%long%!"=="rem" goto comment
goto skip_comment
:comment
echo commento trovato
set /a take=%countchar%-4
echo //!sentence:~4,%take%! >>%output%
:skip_comment

REM //////////////////////////////////////
REM /////////// SET //////////////////////
REM //////////////////////////////////////
set write=
if "!sentence:~%space%,6!"=="set /p" goto cin_input
if "!sentence:~%space%,6!"=="set /a" goto calc_set_a
if "!sentence:~%space%,%long%!"=="set" goto set_control
goto skip_set_control
:set_control
echo comando set trovato
 

set set_normal_where=4
:set_normal_loop1
if not "!sentence:~%set_normal_where%,1!"=="%percent%" set write=%write%!sentence:~%set_normal_where%,1!
if "%set_normal_where%"=="%countchar%" goto exit_set_normal_loop
set /a set_normal_where=%set_normal_where%+1
goto set_normal_loop1
:exit_set_normal_loop

echo %write%; >>%output%

goto skip_set_control

REM //////////////////////////////////////
REM /////////// SET /P / CIN /////////////
REM //////////////////////////////////////

:cin_input
set quotes="

if "!sentence:~%space%,6!"=="set /p" echo comando input trovato
set /a take=%countchar%-7
set where_cin=7
:cin_loop1
if "%where_cin%"=="%countchar%" (echo probabile errore di sinstassi
goto skip_set_control)
if "!sentence:~%where_cin%,1!"=="=" goto pre_cin_loop2
set /a where_cin=%where_cin%+1
goto cin_loop1

:pre_cin_loop2
set where_cin_quotes1=7
:cin_loop2
if "%where_cin_quotes1%"=="%countchar%" goto skip_search_quotes
if "!sentence:~%where_cin_quotes1%,1!"=="!quotes!" goto found_cin_quotes1
set /a where_cin_quotes1=%where_cin_quotes1%+1
goto cin_loop2

:found_cin_quotes1
set /a where_cin_quotes2=%where_cin_quotes1%+1
:cin_loop3
if "%where_cin_quotes2%"=="%countchar%" (echo probabile errore di sinstassi
goto skip_set_control)
if "!sentence:~%where_cin_quotes2%,1!"=="!quotes!" goto found_cin_quotes2
set /a where_cin_quotes2=%where_cin_quotes2%+1
goto cin_loop3

:found_cin_quotes2
echo le virgolette le ho trovate a %where_cin_quotes1% e a %where_cin_quotes2%.
set /a check_third_case=%where_cin_quotes1%-1
if "!sentence:~%check_third_case%,1!"=="=" goto third_case
:skip_search_quotes
echo ho trovato l'uguale a %where_cin%. prima dell'uguale c'e il nome variabile, dopo invece il cout

if not "%where_cin_quotes2%"=="" goto quotes_content
goto noquotes_content
:noquotes_content
set /a take=%where_cin%-7
set input_variable=!sentence:~7,%take%!
echo input_variable !sentence:~7,%take%!
set /a take=%countchar%-%where_cin%-1
set /a where_cin=%where_cin%+1
echo output !sentence:~%where_cin%,%take%!
set output_cin=!sentence:~%where_cin%,%take%!
goto cin_ready_to_output

:quotes_content
set /a take=%where_cin%-%where_cin_quotes1%-1
set /a where_cin_quotes1=%where_cin_quotes1%+1
set input_variable=!sentence:~%where_cin_quotes1%,%take%!
echo input_variable: !sentence:~%where_cin_quotes1%,%take%!
set /a take=%where_cin_quotes2%-%where_cin%-1
set /a where_cin=%where_cin%+1
set output_cin=!sentence:~%where_cin%,%take%!
goto cin_ready_to_output

:third_case
set /a take=%where_cin_quotes2%-%where_cin_quotes1%-1
set /a where_cin_quotes1=%where_cin_quotes1%+1
set output_cin=!sentence:~%where_cin_quotes1%,%take%!

set /a take=%where_cin%-7
set input_variable=!sentence:~7,%take%!

:cin_ready_to_output
if not "!output_cin!"=="" echo cout^<^<"!output_cin!"; >>%output%
echo cin^>^>%input_variable%; >>%output%

goto skip_echo_command

REM //////////////////////////////////////
REM /////////// SET /A ///////////////////
REM //////////////////////////////////////

:calc_set_a
 
set write=
if "!sentence:~%space%,6!"=="set /a" echo comando calcolo trovato

set set_a_where=7
:set_a_loop1
if not "!sentence:~%set_a_where%,1!"=="%percent%" set write=%write%!sentence:~%set_a_where%,1!
if "%set_a_where%"=="%countchar%" goto exit_set_a_loop
set /a set_a_where=%set_a_where%+1
goto set_a_loop1
:exit_set_a_loop

echo %write%; >>%output%

:skip_set_control

REM //////////////////////////////////////
REM /////////// CLS //////////////////////
REM //////////////////////////////////////
if "!sentence:~%space%,%long%!"=="cls" (echo comando cls trovato
echo system ^("cls"^); >>%output%)

REM //////////////////////////////////////
REM /////////// TITLE ////////////////////
REM //////////////////////////////////////
if "!sentence:~%space%,%long%!"=="title" (echo comando title trovato
echo system ^("%sentence%"^); >>%output%)

REM //////////////////////////////////////
REM /////////// COLOR ////////////////////
REM //////////////////////////////////////
if "!sentence:~%space%,%long%!"=="color" (echo comando color trovato
echo system ^("%sentence%"^); >>%output%)

REM //////////////////////////////////////
REM /////////// IF ///////////////////////
REM //////////////////////////////////////
if "!sentence:~%space%,%long%!"=="if" goto if_command
if "!sentence:~%space%,%long%!"=="If" goto if_command
if "!sentence:~%space%,%long%!"=="iF" goto if_command
if "!sentence:~%space%,%long%!"=="IF" goto if_command
goto skip_if_command
:if_command
echo comando if trovato
set quotes="
 

REM /////////// PRIMO VALORE /////////////
if "!sentence:~3,2!"=="!quotes!!percent!" (echo variabile trovata nel primo valore
goto trova_fine_variabile)
if "!sentence:~3,1!"=="!quotes!" (echo nessuna variabile trovata nel primo valore
goto trova_valore1)
echo Probabile errore a riga%numero_ripetizione%!
goto skip_if_command
:trova_fine_variabile
set space_temp=4
:loop_trova_fine_variabile
if "!sentence:~%space_temp%,2!"=="!percent!!quotes!" (echo fine variabile trovata a %space_temp%
goto skip_trova_fine_variabile)
set /a space_temp=%space_temp%+1
if "%space_temp%"=="%countchar%" goto skip_trova_fine_variabile
goto loop_trova_fine_variabile
:skip_trova_fine_variabile
set /a place_val_1=%space_temp%-5
echo la prima variabile dovrebbe essere: !sentence:~5,%place_val_1%!
set v1=!sentence:~5,%place_val_1%!
goto trova_variabile2

:trova_valore1
set space_temp=4
:loop_trova_fine_valore
if "!sentence:~%space_temp%,1!"=="!quotes!" (echo fine valore trovata a %space_temp%
goto skip_trova_fine_valore)
set /a space_temp=%space_temp%+1
if "%space_temp%"=="%countchar%" goto skip_trova_fine_valore
goto loop_trova_fine_valore
:skip_trova_fine_valore
set /a place_val_1=%space_temp%-4
echo il primo valore dovrebbe essere: !sentence:~4,%place_val_1%!
set v1=!sentence:~4,%place_val_1%!

set is_number=1
set is_x=4
set /a is_x_end=4+%place_val_1%
:is_number_try
if "!sentence:~%is_x%,1!"=="0" goto is_number
if "!sentence:~%is_x%,1!"=="1" goto is_number
if "!sentence:~%is_x%,1!"=="2" goto is_number
if "!sentence:~%is_x%,1!"=="3" goto is_number
if "!sentence:~%is_x%,1!"=="4" goto is_number
if "!sentence:~%is_x%,1!"=="5" goto is_number
if "!sentence:~%is_x%,1!"=="6" goto is_number
if "!sentence:~%is_x%,1!"=="7" goto is_number
if "!sentence:~%is_x%,1!"=="8" goto is_number
if "!sentence:~%is_x%,1!"=="9" goto is_number
set is_number=0
:is_number
echo !sentence:~%is_x%,1!: %is_number% at %is_x%
set /a is_x += 1
if "%is_x%"=="%is_x_end%" goto end_is_number_try
goto is_number_try
:end_is_number_try

if "%is_number%"=="0" set v1=!quotes!%v1%!quotes!

goto trova_variabile2

REM /////////// SECONDO VALORE ///////////
:trova_variabile2
set stored_space_temp=%space_temp%
if not "%space_temp%"=="" goto loop_trova_variabile2
set space_temp=4
:loop_trova_variabile2
if "!sentence:~%space_temp%,2!"=="!quotes!!percent!" (echo nuova variabile trovata a %space_temp%
goto trova_fine_variabile2)
set /a space_temp=%space_temp%+1
if "%space_temp%"=="%countchar%" goto trova_eventuale_valore2
goto loop_trova_variabile2

:trova_fine_variabile2
if "%space_temp_old%"=="" set space_temp_old=%space_temp%
if "!sentence:~%space_temp%,2!"=="!percent!!quotes!" (echo fine nuova variabile trovata a %space_temp%
goto skip_trova_fine_variabile2)
set /a space_temp=%space_temp%+1
if "%space_temp%"=="%countchar%" goto trova_eventuale_valore2

goto trova_fine_variabile2
:skip_trova_fine_variabile2
set /a place_val_2=%space_temp%-%space_temp_old%-2
set /a space_temp_old=%space_temp_old%+2
echo la seconda variabile dovrebbe essere: !sentence:~%space_temp_old%,%place_val_2%!
set v2=!sentence:~%space_temp_old%,%place_val_2%!
goto skip_trova_variabile2

:trova_eventuale_valore2
set "space_temp_old="
echo non c'e una seconda variabile, forse e' un valore
set space_temp=%stored_space_temp%+2
:valore2_loop
if "!sentence:~%space_temp%,1!"=="!quotes!" (echo valore trovato a %space_temp%
goto trova_fine_valore2)
set /a space_temp=%space_temp%+1
goto valore2_loop

:trova_fine_valore2
set space_temp_old=%space_temp%
set /a space_temp=%space_temp%+1
:loop_trova_fine_valore2
echo !sentence:~%space_temp%,1!
if "!sentence:~%space_temp%,1!"=="!quotes!" (echo fine valore2 trovata a %space_temp%
goto skip_trova_valore2)
set /a space_temp=%space_temp%+1
if "%space_temp%"=="%countchar%" goto skip_trova_variabile2
goto loop_trova_fine_valore2

:skip_trova_valore2
set /a place_val_2=%space_temp%-%space_temp_old%-1
set /a space_temp_old=%space_temp_old%+1
echo valore2 dovrebbe essere: !sentence:~%space_temp_old%,%place_val_2%!
set v2=!sentence:~%space_temp_old%,%place_val_2%!

set is_number2=1
set is_x2=%space_temp_old%
set /a is_x2_end=%is_x2%+%place_val_2%
:is_number_try2
if "!sentence:~%is_x2%,1!"=="0" goto is_number2
if "!sentence:~%is_x2%,1!"=="1" goto is_number2
if "!sentence:~%is_x2%,1!"=="2" goto is_number2
if "!sentence:~%is_x2%,1!"=="3" goto is_number2
if "!sentence:~%is_x2%,1!"=="4" goto is_number2
if "!sentence:~%is_x2%,1!"=="5" goto is_number2
if "!sentence:~%is_x2%,1!"=="6" goto is_number2
if "!sentence:~%is_x2%,1!"=="7" goto is_number2
if "!sentence:~%is_x2%,1!"=="8" goto is_number2
if "!sentence:~%is_x2%,1!"=="9" goto is_number2
set is_number2=0
:is_number2
echo !sentence:~%is_x2%,1!: %is_number2% at %is_x2%
set /a is_x2 += 1
if "%is_x2%"=="%is_x2_end%" goto end_is_number_try2
goto is_number_try2
:end_is_number_try2
if "%is_number2%"=="0" set v2=!quotes!%v2%!quotes!

:skip_trova_variabile2
echo OUTPUT FINALE DI PROVA:
echo if (%v1%==%v2%)>>%output%

:skip_if_command

REM //////////////////////////////////////
REM /////////// GOTO /////////////////////
REM //////////////////////////////////////
if "!sentence:~0,2!"=="if" goto skip_goto_space_check
if "!sentence:~0,2!"=="If" goto skip_goto_space_check
if "!sentence:~0,2!"=="iF" goto skip_goto_space_check
if "!sentence:~0,2!"=="IF" goto skip_goto_space_check
if not "%space%"=="0" goto skip_goto
:skip_goto_space_check
if "!sentence:~%space%,%long%!"=="goto" goto goto_command_found
if "!sentence:~%space%,%long%!"=="Goto" goto goto_command_found
if "!sentence:~%space%,%long%!"=="GOTO" goto goto_command_found
goto skip_goto

:goto_command_found

set /a take_for_goto=%countchar%-%space%-4
set /a space_new=%space%+4
echo sentence size: %countchar%
echo comando goto trovato
echo goto!sentence:~%space_new%,%take_for_goto%!; >>%output%

:skip_goto

REM //////////////////////////////////////
REM /////////// ECHO /////////////////////
REM //////////////////////////////////////
if "!sentence:~%space%,%long%!"=="echo" goto echo_command
goto skip_echo_command

:echo_command
set write=
set triangle=^<^<
echo comando echo trovato
set /a where_check_echo=%space%+%long%+1
if "!sentence:~%where_check_echo%,3!"=="%percent%%percent%%percent%" goto tripercent
if "!sentence:~%where_check_echo%,1!"=="%percent%" (set old_pos=%where_check_echo%
goto pre_expect_second_percent)
set type=text
set write="!sentence:~%where_check_echo%,1!
set /a where_check_echo=%where_check_echo%+1
goto check_echo

:tripercent
if "%where_check_echo%"=="5" set write="%%%
if not "%where_check_echo%"=="5" set write=!write!%percent%
set /a where_check_echo=%where_check_echo%+3
set type=text

goto check_echo

:pre_expect_second_percent
set /a where_check_echo=%where_check_echo%+1
:expect_second_percent
set type=variable
if "!sentence:~%where_check_echo%,1!"=="%percent%" goto write_first_echo_text
set /a where_check_echo=%where_check_echo%+1
goto expect_second_percent

:write_first_echo_text
set /a take=%where_check_echo%-%old_pos%-1
set /a old_pos=%old_pos%+1
set write=!write!!sentence:~%old_pos%,%take%!!triangle!
set /a where_check_echo=%where_check_echo%+1
goto check_echo

:skip_except_second_percent
set write="%percent%
set where_check_echo=4
goto check_echo

:check_echo
if "!sentence:~%where_check_echo%,1!"=="" goto final_output_echo
if "!sentence:~%where_check_echo%,3!"=="%percent%%percent%%percent%" goto tripercent
if "!sentence:~%where_check_echo%,1!"=="%percent%" goto control_percent
goto skip_control_percent
:control_percent
set old_pos=%where_check_echo%
if "%type%"=="text" set write=!write!"%triangle%
goto pre_expect_second_percent
:skip_control_percent

set type=text
set /a previous_0=%where_check_echo%-3
set /a previous=%where_check_echo%-1
if "!sentence:~%previous_0%,3!"=="%percent%%percent%%percent%" goto skip_previous
if "!sentence:~%previous%,1!"=="%percent%" set write=!write!"
:skip_previous
set write=!write!!sentence:~%where_check_echo%,1!
set /a where_check_echo=%where_check_echo%+1
goto check_echo

:final_output_echo
if "%type%"=="text" set write=!write!"!triangle!
echo cout^<^<!write!endl; >>%output%
:skip_echo_command

set /a space=%countcheck%+1
if "!sentence:~0,6!"=="set /p" (set /a round=%round%+1
goto skip_space_found)
if not "!sentence:~%space%,%long%!"=="" set /a round=%round%+1
if "%sentence%"==" " set /a round=%round%-1

:skip_space_found
if "%countcheck%"=="%countchar%" goto end_count_words
set /a countcheck=%countcheck%+1
goto count_words

:end_count_words
set /a long=%countcheck%-%space%

if not "!sentence:~%space%,%long%!"=="" echo parola trovata da %space% a %countcheck%: !sentence:~%space%,%long%!

REM //////////////////////////////////////
REM /////////// PAUSE ////////////////////
REM //////////////////////////////////////
if "!sentence:~%space%,%long%!"=="pause" (echo comando pause trovato
echo system ^("!riga%numero_ripetizione%!"^); >>%output%)

REM //////////////////////////////////////
REM /////////// CLS //////////////////////
REM //////////////////////////////////////
if "!sentence:~%space%,%long%!"=="cls" (echo comando cls trovato
echo system ^("cls"^); >>%output%)

REM //////////////////////////////////////
REM /////////// COLOR ////////////////////
REM //////////////////////////////////////
if "!sentence:~%space%,%long%!"=="color" (echo comando color trovato
echo system ^("%sentence%"^); >>%output%)

REM //////////////////////////////////////
REM /////////// TITLE ////////////////////
REM //////////////////////////////////////
if "!sentence:~%space%,%long%!"=="title" (echo comando title trovato
echo system ^("%sentence%"^); >>%output%)

REM //////////////////////////////////////
REM /////////// EXIT /////////////////////
REM //////////////////////////////////////
if "!sentence:~%space%,%long%!"=="exit" (echo comando exit trovato
echo system ^("%sentence%"^); >>%output%)

REM //////////////////////////////////////
REM /////////// LABEL ////////////////////
REM //////////////////////////////////////
if "!sentence:~0,1!"==":" goto echo_label
goto skip_label_command
:echo_label
echo comando etichetta trovato
set /a take=%countchar%-1
echo !sentence:~1,%take%!: >>%output%
:skip_label_command

REM //////////////////////////////////////
REM /////////// ECHO. / ENDL /////////////
REM //////////////////////////////////////
if "!sentence:~0,%long%!"=="echo." (echo comando echo. trovato
echo cout^<^<endl; >>%output%)
:total
echo complessivamente ho trovato %round% parole.

if "%numero_ripetizione%"=="%ris%" goto stop_conta_parole
set /a numero_ripetizione=%numero_ripetizione%+1
goto numero_ripetizione

:stop_conta_parole
echo. >>%output%
echo return 0;^} >>%output%
echo.
echo Fine - file salvato come %output%.
del %File%
pause >Nul
exit

:stop
echo.
echo Nessun file caricato.
pause >Nul
exit

:Conta
SETLOCAL
SET cnt=0
FOR /F "tokens=*" %%a IN ( %1 ) DO ( set /a cnt+=1 )
ENDLOCAL & SET %2=%cnt%
EXIT /B 0
