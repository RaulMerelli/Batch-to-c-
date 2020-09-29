# Batch to C++
A code translator from Window/Dos Batch to C++.

Created to partially automate the process of converting code from Batch to C++ and speed up calculations.

Created for those scripts that have become so complicated that they have to be transformed into independent programs.

# Compatibility

<table style="width:100%">
  <tr>
    <th>Batch command</th>
    <th>C++ command</th> 
    <th>Actually Working?</th>
	<th>Batch example code (original)</th>
    <th>C++ example code (converted)</th>
	<th>Conversion is correct?</th> 
	<th>Details</th> 	
  </tr>
  <tr>
    <td>set</td>
    <td>-</td> 
    <td>Partially</td>
	<td>set a=1</td>
	<td>a=1;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>set</td>
    <td>-</td> 
    <td>Partially</td>
	<td>set a=%a%+1</td>
	<td>a=a+1;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>set</td>
    <td>-</td> 
    <td>Partially</td>
	<td>set a=!b!</td>
	<td>a=!b!;</td>
	<td>no</td>
	<td>Doesn't work with delayed expansion variables</td>
  </tr>
  <tr>
    <td>set</td>
    <td>-</td> 
    <td>Partially</td>
	<td>set a=%a%%b%</td>
	<td>a=ab;</td>
	<td>no</td>
	<td>Can't concatenate</td>
  </tr>
  <tr>
    <td>set /a</td>
    <td>-</td> 
    <td>Partially</td>
	<td>set /a a=2+2</td>
	<td>a=2+2;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>set /a</td>
    <td>-</td> 
    <td>Partially</td>
	<td>set /a a=%a%+2</td>
	<td>a=a+2;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>set /a</td>
    <td>-</td> 
    <td>Partially</td>
	<td>set /a a=!a!+2</td>
	<td>a=!a!+2;</td>
	<td>no</td>
	<td>Doesn't work with delayed expansion variables</td>
  </tr>
  <tr>
    <td>set /a</td>
    <td>-</td> 
    <td>Partially</td>
	<td>set /a a=%a%%b%+1</td>
	<td>a=ab+1;</td>
	<td>no</td>
	<td>Can't concatenate</td>
  </tr>
  <tr>
    <td>set /p</td>
    <td>cin</td> 
    <td>yes</td>
	<td>set /p a=Insert</td>
	<td>cout<<"Insert";<br/>cin>>a;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>set /p</td>
    <td>cin</td> 
    <td>yes</td>
	<td>set /p a=</td>
	<td>cin>>a;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>set /p</td>
    <td>cin</td> 
    <td>yes</td>
	<td>set /p "a=Insert a: "</td>
	<td>cout<<"Insert a: ";<br/>cin>>a;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>set /p</td>
    <td>cin</td> 
    <td>yes</td>
	<td>set /p "a="</td>
	<td>cin>>a;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>set /p</td>
    <td>cin</td> 
    <td>yes</td>
	<td>set /p a="Insert a: "</td>
	<td>cout<<"Insert a:";<br/>cin>>a;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>set /p</td>
    <td>cin</td> 
    <td>yes</td>
	<td>set /p a=""</td>
	<td>cin>>a;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>goto</td>
    <td>goto</td> 
    <td>yes</td>
	<td>goto label</td>
	<td>goto label;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>label</td>
    <td>label</td> 
    <td>yes</td>
	<td>:label</td>
	<td>label:</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>color</td>
    <td>system("color");</td> 
    <td>yes</td>
	<td>color 0a</td>
	<td>system("color 0a");</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>cls</td>
    <td>system("cls");</td> 
    <td>yes</td>
	<td>cls</td>
	<td>system("cls");</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>pause</td>
    <td>system("pause");</td> 
    <td>yes</td>
	<td>pause</td>
	<td>system("pause");</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>pause</td>
    <td>system("pause");</td> 
    <td>yes</td>
	<td>pause >nul</td>
	<td>system("pause >nul");</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>title</td>
    <td>system("title");</td> 
    <td>yes</td>
	<td>title This is a title</td>
	<td>system("title This is a title");</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>if</td>
    <td>if</td> 
    <td>Partially</td>
	<td>if "%a%"=="%b%" goto label</td>
	<td>if (a==b)<br>goto label;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>if</td>
    <td>if</td> 
    <td>Partially</td>
	<td>if "%a%"=="hi" goto label</td>
	<td>if (a=="hi")<br>goto label;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>if</td>
    <td>if</td> 
    <td>Partially</td>
	<td>if "hi"=="%b%" goto label</td>
	<td>if ("hi"==b)<br>goto label;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>if</td>
    <td>if</td> 
    <td>Partially</td>
	<td>if "1"=="%b%" goto label</td>
	<td>if (1==b)<br>goto label;</td>
	<td>depends</td>
	<td>If is a number can't distinct int from string</td>
  </tr>
  <tr>
    <td>if</td>
    <td>if</td> 
    <td>Partially</td>
	<td>if "%a%"=="1" goto label</td>
	<td>if (a==1)<br>goto label;</td>
	<td>depends</td>
	<td>If is a number can't distinct int from string</td>
  </tr>
  <tr>
    <td>if</td>
    <td>if</td> 
    <td>Partially</td>
	<td>if "%a%"=="%b%" echo hi</td>
	<td>if (a==b)</td>
	<td>no</td>
	<td>Missing cout, only goto works properly after the if</td>
  </tr>
  <tr>
    <td>if</td>
    <td>if</td> 
    <td>Partially</td>
	<td>if "%a%" EQU "%b%" echo hi</td>
	<td>unknown</td>
	<td>no</td>
	<td>EQU, NEQ, LSS, LEQ, GTR, GEQ are not supported</td>
  </tr>
  <tr>
    <td>if</td>
    <td>if</td> 
    <td>Partially</td>
	<td>if "%a%"=="%b%"(<br>echo hi<br>goto label;)</td>
	<td>unknown</td>
	<td>no</td>
	<td>Missing cout, only goto works properly after the if<br>brackets doesn't exist</td>
  </tr>
  <tr>
    <td>start</td>
    <td>system("start")</td> 
    <td>Partially</td>
	<td>start https://www.website.com</td>
	<td>system("start https://www.website.com")</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>start</td>
    <td>system("start")</td> 
    <td>Partially</td>
	<td>start C:\file.txt</td>
	<td>ostringstream cmd;<br>cmd.str(""); <br>cmd.clear();<br>cmd&#60;&#60;"start C:\file.txt" ; <br>system(cmd.str().c_str()); </td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>start</td>
    <td>system("start")</td> 
    <td>Partially</td>
	<td>start https://www.website.com</td>
	<td>system("start https://www.website.com")</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>for</td>
    <td>for</td> 
    <td>no</td>
	<td>unknown</td>
	<td>no output</td>
	<td>no</td>
	<td>"For" is not supported but will be added.</td>
  </tr>
  <tr>
    <td>echo</td>
    <td>cout</td> 
    <td>Partially</td>
	<td>echo.</td>
	<td>cout&#60;&#60;endl;</td>
	<td>yes</td>
	<td></td>
  </tr>
    <tr>
    <td>echo</td>
    <td>cout</td> 
    <td>Partially</td>
	<td>echo %appdata%</td>
	<td>cout&#60;&#60;appdata&#60;&#60;endl;</td>
	<td>Partially</td>
	<td>Not recognized as enviroment variable</td>
  </tr>
  <tr>
    <td>echo</td>
    <td>cout</td> 
    <td>Partially</td>
	<td>echo hi %a%</td>
	<td>cout&#60;&#60;"hi "&#60;&#60;a&#60;&#60;endl;</td>
	<td>yes</td>
	<td></td>
  </tr>
  <tr>
    <td>echo</td>
    <td>cout</td> 
    <td>Partially</td>
	<td>echo hi !a!</td>
	<td>cout&#60;&#60;"hi !a!"&#60;&#60;endl;</td>
	<td>no</td>
	<td>Doesn't work with delayed expansion variables</td>
  </tr>
  <tr>
    <td>C:\path\to\program.exe</td>
    <td>system("C:\path\to\program.exe")</td> 
    <td>No</td>
	<td>C:\path\to\program.exe</td>
	<td>no output</td>
	<td>no</td>
	<td>external or generic command</td>
  </tr>
</table> 
<br>
<p>Status of version 0.11 - Mantained by Raul Merelli</p>


# Changelog
## 0.11
<ul>
  <li>Added support for one line batch files</li>
  <li>Added support for batch files without @echo off</li>
  <li>Fixed library detector</li>
  <li>Program translated from Italian to English</li>
</ul>
