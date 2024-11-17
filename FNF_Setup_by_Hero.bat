@echo off
title FNF Setup Installer
color 0B
echo Checking for Haxe Installation...
if exist "C:\HaxeToolkit\haxe\haxe.exe" (
    color 0A
    echo Haxe found!
) else (
    color 0C
    echo Haxe not found. 
    echo Press Enter to open the Haxe download website, or any other key to exit.
    pause >nul
    if errorlevel 1 exit /b 
    start https://haxe.org/download/file/4.3.1/haxe-4.3.1-win.exe/
    goto :exit
)

:initialpage
color 0E
cls
echo ------------------------------
echo       Welcome to the.....
echo       FNF Setup Installer
echo -------------------------------
echo - This Script helps to install the correct and specific libraries for FNF
echo ---------------------------------------------------------------------------------
echo - Made By HeroEyad.
echo ---------------------------------------------------------------------------------
echo Press any key to start!
pause >nul

:begin
color 0F
cls
cls='clear'
echo 1) I have everything installed, please start installing libraries.
echo -
echo 2) I don't have Visual Studio tools installed, please install it for me!
echo -
echo 3) I dont have Git, please install it for me! (VERY IMPORTANT!!!)
echo -
echo 4) Credits
echo -
echo 5) Exit

echo -
set /p op= Please choose one of the following options:
color 0F
cls
cls='clear'
if "%op%"=="1" goto engine_selection
if "%op%"=="2" goto op2
if "%op%"=="3" goto op3
if "%op%"=="4" goto op4
if "%op%"=="5" goto op5
set /p op=Option:

:op3
color 0B
start https://github.com/git-for-windows/git/releases/download/v2.45.0.windows.1/Git-2.45.0-64-bit.exe
exit

:op5
goto exit

:engine_selection
color 0C
cls
echo What engine do you use?
echo 1. Psych Engine
echo 2. Kade Engine
echo 3. Base Game (UPDATED V-SLICE!!!)
echo. 
echo Please enter your choice (1 or 2 or 3): 
set /p engineChoice=

if %engineChoice%==1 goto :psych_install
if %engineChoice%==2 goto :kade_install
if %engineChoice%==3 goto :base_install

:invalid_choice
color 0C
echo Invalid choice. Please try again.
goto :engine_selection 

:psych_install
color 0A
echo You have selected Psych Engine.
goto :version

:version
color 0E
cls
echo What Version??
echo 1. Prerelease
echo 2. 0.7.X (0.7 or up to date)
echo 3. 0.6.3
echo. 
echo Please enter your choice (1 or 2 or 3): 
set /p option=

if %option%==1 goto:new
if %option%==2 goto:old
if %option%==3 goto:prerelease

:old
color 0A
cls
echo ------------------------------------------
echo            Starting installation..
echo              Please don't close
echo ------------------------------------------
title FNF Setup - Installing libs, please be patient.
haxelib install lime 8.0.2
haxelib install openfl 9.2.1
haxelib install flixel 5.3.0
haxelib install flixel-ui 2.6.0
haxelib install flixel-tools 1.5.1
haxelib install flixel-addons 3.2.2
haxelib install hxcpp 4.3.2  
haxelib install actuate 1.9.0
haxelib install hscript 2.5.0
haxelib run lime setup
haxelib run lime setup flixel
echo - hxCodec is being installed, set "YES" to version 2.5.1!
haxelib install hxCodec 2.5.1
haxelib set hxCodec 2.5.1
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit
haxelib git hxvm-luajit https://github.com/nebulazorua/hxvm-luajit
haxelib git faxe https://github.com/uhrobots/faxe
goto finish

:prerelease
color 0B
cls
echo ------------------------------------------
echo            Starting Psych Engine Prerelease installation..
echo              Please don't close
echo ------------------------------------------
title FNF Setup - Installing Prerelease libs, please be patient.
haxelib install lime 8.1.2
haxelib install openfl 9.3.3
haxelib install flixel 5.6.1
haxelib install flixel-addons 3.2.2
haxelib install flixel-tools 1.5.1
haxelib install SScript 19.0.618
haxelib install tjson 1.4.0
haxelib git flxanimate https://github.com/Dot-Stuff/flxanimate 768740a56b26aa0c072720e0d1236b94afe68e3e
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit 633fcc051399afed6781dd60cbf30ed8c3fe2c5a
haxelib git hxdiscord_rpc https://github.com/MAJigsaw77/hxdiscord_rpc 3538a1c2bb07b04208cd014220207f8173acdb21
haxelib git hxvlc https://github.com/MAJigsaw77/hxvlc 70e7f5f3e76d526ac6fb8f0e6665efe7dfda589d
haxelib git funkin.vis https://github.com/FunkinCrew/funkVis d5361037efa3a02c4ab20b5bd14ca11e7d00f519
haxelib git grig.audio https://gitlab.com/haxe-grig/grig.audio.git cbf91e2180fd2e374924fe74844086aab7891666
goto finish

:new
color 0A
cls
echo ------------------------------------------
echo            Starting installation..
echo              Please don't close
echo ------------------------------------------
title FNF Setup - Installing libs, please be patient.
haxelib install lime
haxelib install openfl
haxelib install flixel
haxelib install flixel-addons
haxelib install flixel-ui
haxelib install flixel-tools
haxelib install SScript
haxelib install hxCodec
haxelib install hxcpp
haxelib install hscript
haxelib install tjson
haxelib git flxanimate https://github.com/ShadowMario/flxanimate dev
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit
haxelib git hxdiscord_rpc https://github.com/MAJigsaw77/hxdiscord_rpc
goto finish

:kade_install
color 0C
cls
echo ----------------------------------------------------------------------------------------
echo WARNING: Kade Engine installation is not officially supported by Haxe 4.3.1 or 4.2.5 and may have issues!
echo Consider using Psych Engine for a more stable and up-to-date experience.
echo or if you wish to proceed then you have to download Haxe 4.1.5
echo https://haxe.org/download/version/4.1.5/
echo ----------------------------------------------------------------------------------------
echo Do you still want to proceed? (Y/N):
set /p confirm=
if /i "%confirm%"=="y" goto :kade
if /i "%confirm%"=="n" goto :engine_selection

:kade
color 0A
cls
echo ------------------------------------------
echo            Starting installation..
echo              Please don't close
echo ------------------------------------------
title FNF Setup - Installing libs, please be patient.
haxelib install lime 7.9.0
haxelib install openfl
haxelib install flixel
haxelib install flixel-tools
haxelib install flixel-ui
haxelib install hscript
haxelib install flixel-addons
haxelib install actuate
haxelib run lime setup
haxelib run lime setup flixel
haxelib run flixel-tools setup
haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit.git
haxelib git hxvm-luajit https://github.com/nebulazorua/hxvm-luajit
haxelib git faxe https://github.com/uhrobots/faxe
haxelib git polymod https://github.com/MasterEric/polymod.git
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
haxelib git extension-webm https://github.com/KadeDev/extension-webm
haxelib git mconsole https://github.com/massive-oss/mconsole
goto finish

:base_install
color 0E
cls
echo ------------------------------------------
echo            Starting installation..
echo              Please don't close
echo ------------------------------------------
title FNF Setup - Installing libs, please be patient.
haxelib install lime 8.0.2
haxelib install openfl 9.2.1
haxelib install flixel 5.3.0
haxelib install flixel-ui 2.6.0
haxelib install flixel-tools 1.5.1
haxelib install flixel-addons 3.2.2
haxelib install hxcpp 4.3.2  
haxelib install actuate 1.9.0
haxelib install hscript 2.5.0
haxelib run lime setup
haxelib run lime setup flixel
haxelib git flixel-ui https://github.com/haxeui/haxeui-flixel
haxelib git flixel-addons https://github.com/robinhancock/flixel-addons
goto finish

:op2
color 0D
cls
echo ------------------------------------------
echo Installing Visual Studio tools...
echo ------------------------------------------
title FNF Setup Installer (Installing Visual Studio Tools)
curl -# -O https://download.visualstudio.microsoft.com/download/pr/3105fcfe-e771-41d6-9a1c-fc971e7d03a7/8eb13958dc429a6e6f7e0d6704d43a55f18d02a253608351b6bf6723ffdaf24e/vs_Community.exe
vs_Community.exe --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows10SDK.19041 -p
del vs_Community.exe
goto :finish

:op4
color 0F
cls
echo ------------------------------------------
echo             Currently viewing....
echo                Credits page
echo ------------------------------------------
title FNF Setup Installer (Credits Page)
echo  Script made by HeroEyad
echo -
echo  Psych Engine made by ShadowMario
echo -
echo  Kade Engine made by KadeDev
echo -
echo  FNF Base Game (Original) made by Ninjamuffin99
pause >nul

goto begin

:finish
color 0A
cls
echo ------------------------------------------
echo               Success!
echo  Everything has been installed successfully
echo ------------------------------------------
echo       Thank you for using this script!
echo        What else do you want to do?
echo ------------------------------------------
echo -
echo 1) Follow me on Twitter!
echo 2) Subscribe to me on Youtube!
echo 3) Support me by Donating on Ko-fi!
echo 4) Join the Friday Night Moddin' Community!
echo 5) Join the Psych Engine Server!
echo 6) Exit
echo -
set /p op=Please choose an option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
if "%op%"=="3" goto op3
if "%op%"=="4" goto op4
if "%op%"=="5" goto op5
if "%op%"=="6" goto op6

:op1
color 0B
start https://twitter.com/HeroEyad_
exit

:op2
color 0C
start https://www.youtube.com/c/HeroEyad
exit

:op3
color 0A
start https://www.ko-fi.com/heroeyad
exit

:op4
color 0D
start https://discord.gg/fridaynightmoddin
exit

:op5
color 0E
start https://discord.gg/psychengine
exit

:op6
color 0F
goto exit

:exit
color 0
@exit
