#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force
GameNum := 0
PlayerWins := 0
ComputerWins := 0
ChoiceArr := {1: "Rock", 2: "Paper", 3: "Scissors"}
WinnerArr := {1: "Player", 2: "Computer", 3: "Tie"}
Gui, +LastFound -Resize +HwndGuiHwnd
Gui, Margin, 10, 10
Gui, Add, Button, xm ym w100 h26 gButtonHandler, % ChoiceArr[1]
Gui, Add, Button, x+m ym w100 h26 gButtonHandler, % ChoiceArr[2]
Gui, Add, Button, x+m ym w100 h26 gButtonHandler, % ChoiceArr[3]
Gui, Add, ListView, xm y+m w320 r6, % "#|" WinnerArr[1] " (0)|" WinnerArr[2] " (0)|Score"
Gui, Show, AutoSize, % "Rock, Paper, Scissors"
return

ButtonHandler:
    Choice1 := (A_GuiControl = ChoiceArr[1] ? 1 : A_GuiControl = ChoiceArr[2] ? 2 : 3)
    Random, Choice2, 1, 3

    If (Choice1 = 1) {
        Res := (Choice2 = 1 ? WinnerArr[3] : Choice2 = 2 ? WinnerArr[2] : WinnerArr[1])
    }

    If (Choice1 = 2) {
        Res := (Choice2 = 1 ? WinnerArr[1] : Choice2 = 2 ? WinnerArr[3] : WinnerArr[2])
    }

    If (Choice1 = 3) {
        Res := (Choice2 = 1 ? WinnerArr[2] : Choice2 = 2 ? WinnerArr[1] : WinnerArr[3])
    }

    PlayerWins := (Res = WinnerArr[1] ? PlayerWins + 1 : PlayerWins)
    ComputerWins := (Res = WinnerArr[2] ? ComputerWins + 1 : ComputerWins)
    GameNum++

    LV_Insert(1,, GameNum, ChoiceArr[Choice1], ChoiceArr[Choice2], (Res <> "Tie" ? Res " Wins!" : Res))
    LV_ModifyCol(2,, WinnerArr[1] " (" PlayerWins ")")
    LV_ModifyCol(3,, WinnerArr[2] " (" ComputerWins ")")

    Loop, % LV_GetCount("Column") {
        LV_ModifyCol(A_Index, "AutoHdr")
    }
    
    Gui, Show, AutoSize, % "Rock, Paper, Scissors [" PlayerWins ":" ComputerWins "]"
return