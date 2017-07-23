;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force

; Read in current hotkey from ini file
IniRead, muteHotkey, config.ini, Config, Hotkey

; Set up tray menu
Menu, Tray, Icon, muted volume.ico
Menu, Tray, Tip, Mute Current Application
Menu, Tray, Add, Change Hotkey, showGui

Gui, Add, Text, x61 y9 w90 h20 , Enter your hotkey:
Gui, Add, Hotkey, x12 y39 w190 h30 vmuteHotkey, %muteHotkey%
Gui, Add, Button, x56 y79 w100 h30 gsaveButton, Save
; Generated using SmartGUI Creator 4.0
Gui, Show, x720 y321 h134 w216, Change Hotkey
Return

showGui:
Gui, Show, x720 y321 h134 w216, Change Hotkey
Return

saveButton:
Gui, Submit
IniWrite, %muteHotkey%, config.ini, Config, Hotkey
Return

F12::
Reload
Return

