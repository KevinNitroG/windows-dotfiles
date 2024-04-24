; https://www.autohotkey.com/board/topic/15067-scrit-not-recognizing-space-in-window-title/

DetectHiddenWindows true
; SetTitleMatchMode "regex"
; SetTitleMatchMode "RegEx"

; HotIfWinActive "im)^unikey.*"

; #Space::!z
; #Space::SendInput "!z"

; Hotkey "^+",
; #Space::!z
; ^+Shift::return
; Ctrl & Shift::return

; Hotkey "#Space", SendInput "^+"
; LWin & Space::^+


; ^9::MyFunc

; HotIfWinActive

; #HotIf WinActive("im)^unikey.*")

; #Space::SendInput "!z"

; #HotIf

; ControlSend "#Space", "!z", "UniKeyNT.exe"
; ControlSend "#Space", ControlSend("!z"), "UniKeyNT.exe"
; ControlSend "#Space", ControlSend("!z"), "i)^unikey.*"
ControlSend "#Space", ControlSend("!z"), "UniKey 4.6 RC2"
MsgBox "Hey"

MyFunc()
{
    MsgBox "You pressed "
}

ReturnFunc()
{
  return
}

