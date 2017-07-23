;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Tom Scott <tomscott292@gmail.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force

;Global hotkey var
muteHotkey = ''

init:
    Gosub, loadConfig
    Gosub, setUpMenu
    return

loadConfig:
    ;Check for ini file
    IfNotExist, config.ini
        ; if no ini file show gui
        showGui()
    else {
        ; Read in current hotkey from ini file
        IniRead, muteHotkey, config.ini, Config, Hotkey

        ;If no hotkey
        if(!muteHotkey){
            ;show gui
            showGui()
            } else {
                setHotkeyAction(muteHotkey)
            }
        }
    Return

setUpMenu:
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

showGui(){
    Gui, Show, x720 y321 h134 w216, Change Hotkey
    Return
}

saveButton:
    ;get old hotkey and clear action on it
    oldHotkey = %muteHotkey%
    Gui, Submit ; stores new hotkey in muteHotkey
    IniWrite, %muteHotkey%, config.ini, Config, Hotkey ; save key in ini
    setNewHotkey(oldHotkey, muteHotkey)
    Return

setNewHotkey(oldKey, newHotkey){
    ; Don't do anything if key has not changed
    if(oldKey == newHotkey){
        Return
    }

    clearHotkeyAction(oldKey)
    setHotkeyAction(newHotkey)
    Return
}

clearHotkeyAction(key){
    if(key){
        Hotkey, %key%, OFF
    }
    Return
}

setHotkeyAction(key) {
    if(key){
        Hotkey, %key%, muteApplication
    }
    Return
}

muteApplication:
    MsgBox, Hotkey pressed: %muteHotkey%
    ; run nircmd muteappvolume focused 2
    Return

; Debug refresh
F12::
    Reload
    Return

