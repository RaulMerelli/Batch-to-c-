@echo off
setlocal enableDelayedExpansion

set sentence=echo ciao %%r%% %%sentence:~5,8%%
echo %sentence%

set countcheck=0
:retry_count
if "!sentence:~%countcheck%,100!"=="" goto stop_count
set /a countcheck += 1
goto retry_count
:stop_count

set startposition=0
:retry_check_variable
if "!sentence:~%startposition%,1!"=="%%" goto variable_find
set /a startposition += 1
if "%startposition%"=="%countcheck%" goto skip_substr
goto retry_check_variable
:variable_find
set /a startposition+=1

set endposition=0
:retry_check_substr
if "!sentence:~%endposition%,2!"==":~" goto substr
set /a endposition += 1
if "%endposition%"=="%countcheck%" goto skip_substr
goto retry_check_substr

goto skip_substr

:substr
set /a endposition_old=%endposition%+2
set /a endposition -= %startposition%
set comma_pos=0
:retry_check_comma
if "!sentence:~%comma_pos%,1!"=="," goto end_comma_find
set /a comma_pos += 1
if "%comma_pos%"=="%countcheck%" goto skip_substr
goto retry_check_comma

:end_comma_find
set /a take_first_number=%comma_pos%-%endposition_old%
set first_number=!sentence:~%endposition_old%,%take_first_number%!
set /a comma_pos += 1

set position=%startposition%
:retry_check_variable_end
if "!sentence:~%position%,1!"=="%%" goto end_variable_find
set /a position += 1
if "%position%"=="%countcheck%" goto skip_substr
goto retry_check_variable_end
:end_variable_find

set /a take_second_number=%position%-%comma_pos%
set second_number=!sentence:~%comma_pos%,%take_second_number%!

echo !sentence:~%startposition%,%endposition%!.substr(%first_number%,%second_number%)
:skip_substr
pause >Nul